# 엑셀 유틸

```java
package common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 * <p>
 * 엑셀 관련 유틸.
 * </p>
 * <ul>
 * <li>Updated on : 2014-11-11</li>
 * <li>Updated by : 아키텍쳐팀, SK플래닛.</li>
 * </ul>
 */
public class ExcelUtils {

	/**
	 * Excel WorkBook 가져오기.
	 *
	 * @param fileName
	 *            파일명
	 *
	 * @return {@link XSSFWorkbook}
	 */
	public static XSSFWorkbook getWorkbook(String fileName) {
		try {
			return new XSSFWorkbook(new FileInputStream(new File(fileName)));
		} catch (FileNotFoundException e) {
			throw new RuntimeException("### 엑셀 파일을 찾을 수 없습니다.");
		} catch (IOException e) {
			throw new RuntimeException("### 엑셀 Workbook 읽기 도중에 오류가 발생했습니다.");
		}
	}

	/**
	 * 엑셀 시트 가져오기.
	 *
	 * @param fileName
	 *            File Name
	 * @param sheetName
	 *            엑셀 시트 Name
	 * @return {@link XSSFSheet}
	 */
	public static XSSFSheet getSheet(String fileName, String sheetName) {
		XSSFWorkbook workbook = getWorkbook(fileName);

		if (workbook == null) {
			return null;
		} else {
			return workbook.getSheet(sheetName);
		}
	}

	/**
	 * Excel Cell 가져오기.
	 *
	 * @param sheet
	 *            {@link XSSFSheet}
	 * @param rowIndex
	 *            Row Index
	 * @param columnIndex
	 *            Column Index
	 * @return {@link XSSFCell}
	 */
	public static XSSFCell getCell(XSSFSheet sheet, Integer rowIndex, Integer columnIndex) {
		XSSFRow row = sheet.getRow(rowIndex);

		if (row == null) {
			return null;
		} else {
			return row.getCell(columnIndex);
		}
	}

	/**
	 * Excel Cell 값 가져오기.
	 *
	 * @param cell
	 *            {@link XSSFCell}
	 * @param defaultValue
	 *            기본 값
	 * @return Excel Cell 값
	 */
	@SuppressWarnings("deprecation")
	public static String getCellString(XSSFCell cell, String defaultValue) {
		String value = null;

		if (cell == null) {
			return defaultValue;
		}

		switch (cell.getCellType()) {
		case Cell.CELL_TYPE_STRING:
			value = cell.getStringCellValue();
			break;
		case Cell.CELL_TYPE_NUMERIC:
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

			if (DateUtil.isCellDateFormatted(cell)) {
				value = df.format(cell.getDateCellValue());
			} else {
				value = df.format(cell.getNumericCellValue());
				// value = String.valueOf(cell.getNumericCellValue());
			}
			break;
		case Cell.CELL_TYPE_BOOLEAN:
			// System.out.println("BooleanCellValue : " + cell.getBooleanCellValue());
			value = (cell.getBooleanCellValue()) ? "true" : "false";
			break;
		case Cell.CELL_TYPE_FORMULA:
			value = cell.getRawValue();
			break;
		case Cell.CELL_TYPE_BLANK:
			value = cell.getStringCellValue();
			break;
		case Cell.CELL_TYPE_ERROR:
			value = cell.getErrorCellString();
			break;
		default:
			value = "/" + cell.getCellType() + "/" + cell.toString() + "/";
		}

		return value;
	}

	/**
	 * 엑셀 시트의 모든 값을 리스트로 가져오기.
	 *
	 * @param sheet
	 *            엑셀 시트
	 * @param columnIndexFrom
	 *            시작 컬럼 위치
	 * @param columnIndexTo
	 *            종료 컬럼 위치
	 * @return 엑셀 리스트
	 */
	public static List<List<String>> getTableStrings(XSSFSheet sheet, Integer columnIndexFrom, Integer columnIndexTo) {
		List<List<String>> returnList = new ArrayList<List<String>>();
		List<String> rowList = null;
		Integer rowIndex = 0;

		while (true) {
			rowList = getRowStrings(sheet, rowIndex, columnIndexFrom, columnIndexTo);

			if (sheet.getLastRowNum() < rowIndex) {
				break;
			}
			rowIndex++;

			returnList.add(rowList);
		}

		return returnList;
	}

	/**
	 * 엑셀 시트에서 선택된 Row의 시작 컬럼과 종료 컬럼까지 값 가져오기.
	 *
	 * @param sheet
	 *            엑셀 시트
	 * @param rowIndex
	 *            선택된 Row
	 * @param columnIndexFrom
	 *            From Column Index
	 * @param columnIndexTo
	 *            To Column Index
	 * @return Excel 값
	 */
	public static List<String> getRowStrings(XSSFSheet sheet, Integer rowIndex, Integer columnIndexFrom,
			Integer columnIndexTo) {
		List<String> list = new LinkedList<String>();

		for (Integer columnIndex = columnIndexFrom; columnIndex <= columnIndexTo; columnIndex++) {
			list.add(getCellString(getCell(sheet, rowIndex, columnIndex), ""));
		}

		return list;
	}

}
```

[참고 깃허브](https://github.com/devkskim/dsp-framework-common/blob/957b826e3c3f93f0e37d29851d7281634b82d3d1/src/main/java/common/util/ExcelUtils.java)
