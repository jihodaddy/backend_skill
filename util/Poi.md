# Java Excel 파일 라이브러리 (POI)

- pom.xml설정

```java
<dependency>
	<groupId>org.apache.poi</groupId>
	<artifactId>poi</artifactId>
	<version>3.7</version>
</dependency>
<dependency>
	<groupId>org.apache.poi</groupId>
	<artifactId>poi-ooxml</artifactId>
	<version>3.7</version>
</dependency>
```

- 순서

1. workbook 을 생성한다.
2. workbook 내에 sheet를 생성한다.
3. sheet 내에 row를 생성한다.
4. 하나의 row에 여러개의 cell을 생성한다. (= 하나의 행에 여러 열을 생성한다)
5. 3과 4의 과정을 계속해서 반복한다.

### 파일 생성하기

- 소스1

```java
import java.awt.Color;
import java.io.File;
import java.io.FileOutputStream;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;


public class ExcelDownTest {
	public static void main(String[] args) throws Exception{

		// .xls 확장자 지원

		// HSSFWorkbook hssWb = null;
		// HSSFSheet hssSheet = null;
		// Row hssRow = null;
		// Cell hssCell = null;

		//.xlsx 확장자 지원

		XSSFWorkbook xssfWb = null;
		XSSFSheet xssfSheet = null;
		XSSFRow xssfRow = null;
		XSSFCell xssfCell = null;

		try {
			int rowNo = 0; // 행의 갯수

			xssfWb = new XSSFWorkbook(); //XSSFWorkbook 객체 생성
			xssfSheet = xssfWb.createSheet("워크 시트1"); // 워크시트 이름 설정

			// 폰트 스타일
			XSSFFont font = xssfWb.createFont();
			font.setFontName(HSSFFont.FONT_ARIAL); // 폰트 스타일
			font.setFontHeightInPoints((short)20); // 폰트 크기
			font.setBold(true); // Bold 설정
			font.setColor(new XSSFColor(Color.decode("#457ba2"))); // 폰트 색 지정

			//테이블 셀 스타일
			CellStyle cellStyle = xssfWb.createCellStyle();
			xssfSheet.setColumnWidth(0, (xssfSheet.getColumnWidth(0))+(short)2048); // 0번째 컬럼 넓이 조절

			cellStyle.setFont(font); // cellStyle에 font를 적용
			cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 정렬

			//셀병합
			xssfSheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 4)); //첫행, 마지막행, 첫열, 마지막열 병합

			// 타이틀 생성
			xssfRow = xssfSheet.createRow(rowNo++); // 행 객체 추가
			xssfCell = xssfRow.createCell((short) 0); // 추가한 행에 셀 객체 추가
			xssfCell.setCellStyle(cellStyle); // 셀에 스타일 지정
			xssfCell.setCellValue("타이틀 입니다"); // 데이터 입력

			xssfSheet.createRow(rowNo++);
			xssfRow = xssfSheet.createRow(rowNo++);  // 빈행 추가

			//테이블 스타일 설정
			CellStyle tableCellStyle = xssfWb.createCellStyle();
			tableCellStyle.setBorderTop((short) 5);    // 테두리 위쪽
			tableCellStyle.setBorderBottom((short) 5); // 테두리 아래쪽
			tableCellStyle.setBorderLeft((short) 5);   // 테두리 왼쪽
			tableCellStyle.setBorderRight((short) 5);  // 테두리 오른쪽

			xssfRow = xssfSheet.createRow(rowNo++);
			xssfCell = xssfRow.createCell((short) 0);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("셀1");
			xssfCell = xssfRow.createCell((short) 1);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("셀2");
			xssfCell = xssfRow.createCell((short) 2);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("셀3");
			xssfCell = xssfRow.createCell((short) 3);
			xssfCell.setCellStyle(tableCellStyle);
			xssfCell.setCellValue("셀4");
			xssfCell = xssfRow.createCell((short) 4);
			xssfCell.setCellStyle(tableCellStyle);

			String localFile = "/Users/hihi/" + "excelDownTest" + ".xlsx";

			File file = new File(localFile);
			FileOutputStream fos = null;
			fos = new FileOutputStream(file);
			xssfWb.write(fos);

			if (fos != null) fos.close();
		}catch(Exception e){

		}
	}
}
```

- 소스2

```java
package practice.test;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

public class PoiMakeExcel {

    public static String filePath = "C:\\poi_temp";
    public static String fileNm = "poi_making_file_test.xlsx";

    public static void main(String[] args) {

        // 빈 Workbook 생성
        XSSFWorkbook workbook = new XSSFWorkbook();

        // 빈 Sheet를 생성
        XSSFSheet sheet = workbook.createSheet("employee data");

        // Sheet를 채우기 위한 데이터들을 Map에 저장
        Map<String, Object[]> data = new TreeMap<>();
        data.put("1", new Object[]{"ID", "NAME", "PHONE_NUMBER"});
        data.put("2", new Object[]{"1", "cookie", "010-1111-1111"});
        data.put("3", new Object[]{"2", "sickBBang", "010-2222-2222"});
        data.put("4", new Object[]{"3", "workingAnt", "010-3333-3333"});
        data.put("5", new Object[]{"4", "wow", "010-4444-4444"});

        // data에서 keySet를 가져온다. 이 Set 값들을 조회하면서 데이터들을 sheet에 입력한다.
        Set<String> keyset = data.keySet();
        int rownum = 0;

        // 알아야할 점, TreeMap을 통해 생성된 keySet는 for를 조회시, 키값이 오름차순으로 조회된다.
        for (String key : keyset) {
            Row row = sheet.createRow(rownum++);
            Object[] objArr = data.get(key);
            int cellnum = 0;
            for (Object obj : objArr) {
                Cell cell = row.createCell(cellnum++);
                if (obj instanceof String) {
                    cell.setCellValue((String)obj);
                } else if (obj instanceof Integer) {
                    cell.setCellValue((Integer)obj);
                }
            }
        }

        try {
            FileOutputStream out = new FileOutputStream(new File(filePath, fileNm));
            workbook.write(out);
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
```

### 엑셀 파일 읽기

```java
package practice.test;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Iterator;

public class PoiReadExcel {

    public static String filePath = "C:\\poi_temp";
    public static String fileNm = "poi_reading_test.xlsx";

    public static void main(String[] args) {

        try {
            FileInputStream file = new FileInputStream(new File(filePath, fileNm));

            // 엑셀 파일로 Workbook instance를 생성한다.
            XSSFWorkbook workbook = new XSSFWorkbook(file);

            // workbook의 첫번째 sheet를 가저온다.
            XSSFSheet sheet = workbook.getSheetAt(0);

            // 만약 특정 이름의 시트를 찾는다면 workbook.getSheet("찾는 시트의 이름");
            // 만약 모든 시트를 순회하고 싶으면
            // for(Integer sheetNum : workbook.getNumberOfSheets()) {
            //      XSSFSheet sheet = workbook.getSheetAt(i);
            // }
            // 아니면 Iterator<Sheet> s = workbook.iterator() 를 사용해서 조회해도 좋다.

            // 모든 행(row)들을 조회한다.
            Iterator<Row> rowIterator = sheet.iterator();
            while (rowIterator.hasNext()) {
                Row row = rowIterator.next();

                // 각각의 행에 존재하는 모든 열(cell)을 순회한다.
                Iterator<Cell> cellIterator = row.cellIterator();

                while (cellIterator.hasNext()) {
                    Cell cell = cellIterator.next();

                    // cell의 타입을 하고, 값을 가져온다.
                    switch (cell.getCellType()) {
                        case NUMERIC:
                            System.out.print((int) cell.getNumericCellValue() + "\t"); //getNumericCellValue 메서드는 기본으로 double형 반환
                            break;
                        case STRING:
                            System.out.print(cell.getStringCellValue() + "\t");
                            break;
                    }
                }
                System.out.println();
            }
            file.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}
```

### 엑셀 수식 넣기

```java
package practice.test;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

public class PoiFormulaCell {

    public static String filePath = "C:\\poi_temp";
    public static String fileNm = "poi_formula_test.xlsx";

    public static void main(String[] args) {
        XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFSheet sheet = workbook.createSheet("example");

        Row header = sheet.createRow(0);
        header.createCell(0).setCellValue("width");
        header.createCell(1).setCellValue("height");
        header.createCell(2).setCellValue("area");


        Row dataRow = sheet.createRow(1);
        dataRow.createCell(0).setCellValue(100);
        dataRow.createCell(1).setCellValue(100);
        dataRow.createCell(2).setCellFormula("A2*B2");

        try {
            FileOutputStream out = new FileOutputStream(new File(filePath, fileNm));
            workbook.write(out);
            out.close();

        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}
```

### 엑셀 수식값 읽기

```java
package practice.test;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Iterator;

public class PoiReadFormula {


    public static String filePath = "C:\\poi_temp";
    public static String fileNm = "poi_formula_test.xlsx";

    public static void main(String[] args) {

        try (FileInputStream file = new FileInputStream(new File(filePath, fileNm))) {

            XSSFWorkbook workbook = new XSSFWorkbook(file);

            FormulaEvaluator evaluator = workbook.getCreationHelper().createFormulaEvaluator();

            XSSFSheet sheet = workbook.getSheetAt(0);

            for (Row row : sheet) {
                if(row.getRowNum() == 0 ) { continue; }

                Iterator<Cell> cellIterator = row.cellIterator();

                while (cellIterator.hasNext()) {

                    Cell cell = cellIterator.next();
                    System.out.print("변환전: " + cell);
                    System.out.print(" / ");
                    System.out.println("변환후: " + evaluator.evaluateInCell(cell));

                    // 굳이 타입을 확인하고 싶다면 아래처럼 할 수도 있다.
                    /*
                    switch (evaluator.evaluateInCell(cell).getCellType()) {

                        case NUMERIC:
                            System.out.println(cell.getNumericCellValue() + "\t");
                            break;
                        case STRING:
                            System.out.println(cell.getStringCellValue() + "\t");
                            break;
                        case FORMULA:
                            //
                            break;
                    }
                    */
                }
                System.out.println("");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }


    }
}
```

[참고](https://www.egovframe.go.kr/wiki/doku.php?id=egovframework:rte3:fdl:exceld)
