# Excel 저장 연습

### controller
```java
	@GetMapping("excel")
	public void excelDown(HttpServletResponse response) throws Exception {
		List<BrdhIfCarr> carr = brdhIfCarrService.findAll();
		List<BrdhIfCarrResult> list = MapperUtils.convertList(carr, BrdhIfCarrResult.class);

		ExcelService excel = new ExcelService();
		excel.createExcelToResponse(list, "responeexcel", response);
	}
```

### ExcelService.java
```java
package cbhs.brdh.utils;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.stereotype.Service;

import cbhs.brdh.mdm.ifcarr.model.vm.BrdhIfCarrResult;

public class ExcelService {

	public void createExcel(Sheet sheet, List<BrdhIfCarrResult> list) {

//		SXSSFWorkbook workbook = new SXSSFWorkbook();
//		SXSSFSheet sheet = workbook.createSheet("Carrier");

		sheet.setColumnWidth(0, 1500);
		sheet.setColumnWidth(0, 3000);
		sheet.setColumnWidth(0, 3000);
		sheet.setColumnWidth(0, 1500);

		Row headeRow = sheet.createRow(0);

		Cell headCell = headeRow.createCell(0);
		headCell.setCellValue("no");

		headCell = headeRow.createCell(1);
		headCell.setCellValue("carr_cd");
		headCell = headeRow.createCell(2);
		headCell.setCellValue("carr_nm");

		Row bodyRow = null;
		Cell bodyCell = null;

		for (int i = 0; i < list.size(); i++) {
			bodyRow = sheet.createRow(i+1);
			bodyCell = bodyRow.createCell(0);
			bodyCell.setCellValue(i+1);

			bodyCell = bodyRow.createCell(1);
			bodyCell.setCellValue(list.get(i).getCarrCd());

			bodyCell = bodyRow.createCell(2);
			bodyCell.setCellValue(list.get(i).getCarrNm());
		}
	}

	public void createExcelToResponse(List<BrdhIfCarrResult>list, String filename, HttpServletResponse response) throws IOException{
		Workbook workbook = new SXSSFWorkbook();
        Sheet sheet = workbook.createSheet("데이터");

        createExcel(sheet, list);

        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", String.format("atachment;filename=%s.xlsx", filename));

        workbook.write(response.getOutputStream());
        workbook.close();
	}


	public void createExcelTOFile (List<BrdhIfCarrResult>list, String filepath) throws FileNotFoundException, IOException {
		Workbook workbook = new SXSSFWorkbook();
		Sheet sheet = workbook.createSheet("Carrier");

		createExcel(sheet, list);
		filepath = "C:\\Users\\lastb\\Documents\\temp_excel.xlsx";

		FileOutputStream fos = new FileOutputStream(new File(filepath));
		workbook.write(fos);
		workbook.close();

		}


}

```