# 엑셀 업로드 유틸

```java
package com.tagoplus.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Row.MissingCellPolicy;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.MultiValueMap;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ibm.icu.text.SimpleDateFormat;

import egovframework.com.cmm.service.EgovProperties;

/**
 * 엑셀 업로드 유틸리티
 * @author wimy
 *
 */
public class ExcelUploadUtil {

	private static final Logger logger = LoggerFactory.getLogger(ExcelUploadUtil.class);

	/**
	 * 업로드 엑셀 읽기 - 파일 한 개만 지원<br>
	 *  - 엑셀 파일의 첫 번째 레코드를 HasMap 키 이름으로 사용 - 엑셀 파일의 두 번째 레코드부터 데이터로 저장<br>
	 * @param request
	 * @param uploadFolder
	 * @return
	 * @throws Exception
	 */
	public static List<HashMap<String, String>> readExcel(MultipartHttpServletRequest request, String uploadFolder) throws Exception {
		return readExcel(request, uploadFolder, null);
	}

	/**
	 * 업로드 엑셀 읽기 - 파일 한 개만 지원, 첫 번째 시트만 처리<br><br>
	 *   - 지정한 배열로 HashMap key name 적용<br>
	 *   - 엑셀 파일의 첫 번째 레코드부터 데이터로 저장<br>
	 * @param request
	 * @param uploadFolder
	 * @param columnNames null일 경우 엑셀 첫 레코드를 컬럼 이름으로 사용
	 * @return
	 * @throws Exception
	 */
	public static List<HashMap<String, String>> readExcel(MultipartHttpServletRequest request, String uploadFolder, String[] columnNames) throws Exception {
		return readExcel(request, uploadFolder, columnNames, 1);
	}

	/**
	 * 업로드 엑셀 읽기 - 파일 한 개만 지원, 첫 번째 시트만 처리<br><br>
	 *
	 * @param request
	 * @param uploadFolder : 서브 디렉토리 : 빈 값 =/uploadRoot/com/[yyyyMMdd]/, 값이 있으면=/uploadRoot/[uploadFolder]
	 * @param columnNames : HasMap key name : null일 경우 엑셀 첫 레코드를 컬럼 이름으로 사용
	 * @param startRecord : 데이터를 가져올 시작 레코드 : 첫 레코드 = 1
	 * @return
	 * @throws Exception
	 */
	public static List<HashMap<String, String>> readExcel(MultipartHttpServletRequest request, String uploadFolder, String[] columnNames, int startRecord) throws Exception {

		MultiValueMap<String, MultipartFile> files = request.getMultiFileMap();

		String sUploadPathProperty = "upload.path.physical." + EgovProperties.getProperty("globals.web.mode");
		String sSubDir = uploadFolder;

		if (StringUtil.isEmpty(sSubDir)) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM", Locale.getDefault());
			sSubDir = EgovProperties.getProperty("upload.path.common") + "/" + sdf.format(new Date()) + "/";
		}
		File uploadPath = new File(EgovProperties.getProperty(sUploadPathProperty), sSubDir);
		if (!uploadPath.exists())
			uploadPath.mkdirs();

		List<HashMap<String, String>> list = null;

		for (String param : files.keySet()) {

			List<MultipartFile> fileList = files.get(param);

			//MimeUtil mu = new MimeUtil();
			//boolean isExcel = mu.isEnableMimeTypes(fileList, "application/vnd.ms-excel", "application/vnd.openxmlformats");
			//if (!isExcel)
			//	throw new FileUploadException("지원되지 않는 형식의 파일입니다.\n엑셀 파일만 업로드할 수 있습니다.");

			if (fileList.size() > 0) {
				MultipartFile file = fileList.get(0);

				File savedFile = new File(uploadPath, file.getOriginalFilename());
				file.transferTo(savedFile);
				list = readExcel(savedFile, columnNames, startRecord);
			}
		}

		return list;
	}

	/**
	 * 업로드 엑셀 읽기 - 파일 한 개만 지원, 모든 시트 처리
	 * @param request
	 * @param uploadFolder
	 * @param columnNames
	 * @param startRecord
	 * @return
	 * @throws Exception
	 */
	public static HashMap<String, List<HashMap<String, String>>> readExcelSheets(MultipartHttpServletRequest request, String uploadFolder, String[] columnNames, int startRecord) throws Exception {
		MultiValueMap<String, MultipartFile> files = request.getMultiFileMap();

		String sUploadPathProperty = "upload.path.physical." + EgovProperties.getProperty("globals.web.mode");
		String sSubDir = uploadFolder;

		if (StringUtil.isEmpty(sSubDir)) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM", Locale.getDefault());
			sSubDir = EgovProperties.getProperty("upload.path.common") + "/" + sdf.format(new Date()) + "/";
		}
		File uploadPath = new File(EgovProperties.getProperty(sUploadPathProperty), sSubDir);
		if (!uploadPath.exists())
			uploadPath.mkdirs();

		HashMap<String, List<HashMap<String, String>>> list = null;

		for (String param : files.keySet()) {
			List<MultipartFile> fileList = files.get(param);
			//MimeUtil mu = new MimeUtil();
			//boolean isExcel = mu.isEnableMimeTypes(fileList, "application/vnd.ms-excel", "application/vnd.openxmlformats");
			//if (!isExcel)
			//	throw new FileUploadException("지원되지 않는 형식의 파일입니다.\n엑셀 파일만 업로드할 수 있습니다.");
			if (fileList.size() > 0) {
				MultipartFile file = fileList.get(0);
				File savedFile = new File(uploadPath, file.getOriginalFilename());
				file.transferTo(savedFile);
				list = readExcelSheets(savedFile, columnNames, startRecord);
			}
		}

		return list;
	}

	/**
	 * 엑셀 파일 읽어오기 - Workbook 인터페이스 적용<br>
	 * 	- 첫 번째 시트만 처리<br>
	 *  - 주의 : 숫자형 데이터는 기본적으로 double type으로 반환. 숫자형 데이터가 .0으로 끝날 경우 int로 변환하여 반환<br>
	 *  - 키 이름 미지정 가능 : 엑셀 첫 레코드를 키 이름으로 사용 <br>
	 * @param saveFile
	 * @param keyNm 리턴 hashmap에 부여될 키 이름. null일 경우 엑셀 첫 레코드를 키 이름으로 사용
	 * @return
	 * @throws Exception
	 */
	private static List<HashMap<String, String>> readExcel(File saveFile, String[] keyNm) throws Exception {
		return readExcel(saveFile, keyNm, 1);
	}


	/**
	 * 엑셀 파일 읽어오기 - Workbook 인터페이스 적용<br>
	 * 	- 첫 번째 시트만 처리<br>
	 *  - 주의 : 숫자형 데이터는 기본적으로 double type으로 반환. 숫자형 데이터가 .0으로 끝날 경우 int로 변환하여 반환<br>
	 *  - 키 이름 미지정 가능 : 엑셀 첫 레코드를 키 이름으로 사용 <br>
	 * @param saveFile
	 * @param keyNm 리턴 hashmap에 부여될 키 이름. null일 경우 엑셀 첫 레코드를 키 이름으로 사용
	 * @param startRecord 데이터를 가져올 시작 레코드 : 첫 레코드 = 1
	 * @return
	 * @throws Exception
	 */
	private static List<HashMap<String, String>> readExcel(File saveFile, String[] keyNm, int startRecord) throws Exception {
		Workbook wb = WorkbookFactory.create(saveFile);
		wb.setMissingCellPolicy(MissingCellPolicy.CREATE_NULL_AS_BLANK);
		FormulaEvaluator evaluator = wb.getCreationHelper().createFormulaEvaluator();

		List<HashMap<String, String>> excelRows = new ArrayList<HashMap<String, String>>();

		boolean hasKeyName = true;
		if (keyNm == null)
			hasKeyName = false;


		try {

			//hashmap용 key이름이 없을 경우 엑셀 1st row를 key 이름으로 설정
			if (!hasKeyName && wb.getSheetAt(0).getLastRowNum() > 0) {
				keyNm = new String[wb.getSheetAt(0).getRow(0).getLastCellNum()];
				for (int i = 0; i < wb.getSheetAt(0).getRow(0).getLastCellNum(); i++)
					try {
						keyNm[i] = wb.getSheetAt(0).getRow(0).getCell(i).getStringCellValue();
					}
					catch (Exception e) {
						keyNm[i] = "";
					}
			}

			//int iRow = 0;
			for (Row row : wb.getSheetAt(0)) {
				//logger.debug(">>>>>>>>>>>>> excel row : {}", ++iRow);
				if (!hasKeyName && row.getRowNum() == 0)
					continue;

				if (startRecord > row.getRowNum() + 1)
					continue;


				HashMap<String, String> excelCols = new HashMap<String, String>();

				//주의 : foreach를 사용할 경우 컬럼이 빈 값이면 해당 컬럼 자제가 없어짐 (컬럼 인덱스가 달라짐)
				for (int i = 0; i < row.getLastCellNum(); i++) {

					//cell을 가져올 때 MissingCellPolicy.CREATE_NULL_AS_BLANK 옵션 사용 필수 : 빈 컬럼일 때도 빈 값을 가져옴. poi v3.16이상 지원
					Cell cell = row.getCell(i, MissingCellPolicy.CREATE_NULL_AS_BLANK);
					String strVal = "";
					//logger.debug(">>>>> {}, {}, {}", cell.getColumnIndex(), keyNm[cell.getColumnIndex()], cell.getCellTypeEnum().equals(CellType.NUMERIC) ? cell.getNumericCellValue() : cell.getStringCellValue());
					switch (cell.getCellTypeEnum()) {
						case NUMERIC:
							if (DateUtil.isCellDateFormatted(cell)) {
								Date dateValue = cell.getDateCellValue();
								SimpleDateFormat sdf = new SimpleDateFormat(EgovProperties.getProperty("common.date.type"));
								strVal = sdf.format(dateValue);
							}
							else {
								if (String.valueOf(cell.getNumericCellValue()).matches("[\\d]{1,}\\.0$"))
									strVal = String.valueOf(Double.valueOf(cell.getNumericCellValue()).intValue());
								else
									strVal = String.valueOf(cell.getNumericCellValue());
							}
							break;

						case FORMULA:
							strVal = evaluator.evaluate(cell).getStringValue(); // .getCellFormula();
							break;

						case BOOLEAN:
							if (cell.getBooleanCellValue())
								strVal = "true";
							else
								strVal = "false";
							break;

//							case Cell.CELL_TYPE_ERROR:
//								break;
//
						case _NONE:
						case BLANK:
							strVal = "";
							break;

						default:
							strVal = cell.getStringCellValue();
							break;
					}

					//issue : 컬럼 헤더 개수와 레코드 컬럼 개수가 맞지 않는 문제 발생
					if ((i + 1) <= keyNm.length)
						excelCols.put(keyNm[cell.getColumnIndex()], strVal);
				}
				//logger.debug(">>>>>>>>>>>>> excelCols : {}", excelCols.toString());
				excelRows.add(excelCols);
			}
			//logger.debug(">>>>>>>>>> saveFile : {}", saveFile.getAbsolutePath());
		}
		catch (Exception ex) {
			logger.error(ex.getMessage(), ex);
			throw ex;
		}
		finally {
			wb.close();
			if (saveFile.exists())
				saveFile.delete();
		}

		return excelRows;
	}


	private static HashMap<String, List<HashMap<String, String>>> readExcelSheets(File saveFile, String[] keyNm, int startRecord) throws Exception {
		HashMap<String, List<HashMap<String, String>>> excels = new HashMap<>();

		Workbook wb = WorkbookFactory.create(saveFile);
		wb.setMissingCellPolicy(MissingCellPolicy.CREATE_NULL_AS_BLANK);
		FormulaEvaluator evaluator = wb.getCreationHelper().createFormulaEvaluator();

		boolean hasKeyName = true;
		if (keyNm == null)
			hasKeyName = false;

		try {
			//repeat sheet
			for (int i = 0; i < wb.getNumberOfSheets(); i++) {
				List<HashMap<String, String>> excelRows = new ArrayList<HashMap<String, String>>();

				//키 이름이 없을 경우 엑셀 첫 레코드를 키 이름으로 사용
				if (!hasKeyName && wb.getSheetAt(i).getLastRowNum() > 0) {
					keyNm = new String[wb.getSheetAt(i).getRow(0).getLastCellNum()];
					for (int j = 0; j < wb.getSheetAt(i).getRow(0).getLastCellNum(); j++)
						try {
							keyNm[j] = wb.getSheetAt(i).getRow(0).getCell(i).getStringCellValue();
						}
						catch (Exception e) {
							keyNm[j] = "";
						}
				}

				for (Row row : wb.getSheetAt(i)) {
					if (!hasKeyName && row.getRowNum() == 0)
						continue;

					if (startRecord > row.getRowNum() + 1)
						continue;

					HashMap<String, String> excelCols = new HashMap<String, String>();

					//주의 : foreach를 사용할 경우 컬럼이 빈 값이면 해당 컬럼 자제가 없어짐 (컬럼 인덱스가 달라짐)
					for (int k = 0; k < row.getLastCellNum(); k++) {
						//cell을 가져올 때 MissingCellPolicy.CREATE_NULL_AS_BLANK 옵션 사용 필수 : 빈 컬럼일 때도 빈 값을 가져옴. poi v3.16이상 지원
						Cell cell = row.getCell(k, MissingCellPolicy.CREATE_NULL_AS_BLANK);
						String strVal = "";
						//logger.debug(">>>>> {}, {}, {}", cell.getColumnIndex(), keyNm[cell.getColumnIndex()], cell.getCellTypeEnum().equals(CellType.NUMERIC) ? cell.getNumericCellValue() : cell.getStringCellValue());
						switch (cell.getCellTypeEnum()) {
							case NUMERIC:
								if (DateUtil.isCellDateFormatted(cell)) {
									Date dateValue = cell.getDateCellValue();
									SimpleDateFormat sdf = new SimpleDateFormat(EgovProperties.getProperty("common.date.type"));
									strVal = sdf.format(dateValue);
								}
								else {
									if (String.valueOf(cell.getNumericCellValue()).matches("[\\d]{1,}\\.0$"))
										strVal = String.valueOf(Double.valueOf(cell.getNumericCellValue()).intValue());
									else
										strVal = String.valueOf(cell.getNumericCellValue());
								}
								break;

							case FORMULA:
								strVal = evaluator.evaluate(cell).getStringValue(); // .getCellFormula();
								break;

							case BOOLEAN:
								if (cell.getBooleanCellValue())
									strVal = "true";
								else
									strVal = "false";
								break;

							case ERROR:
							case _NONE:
							case BLANK:
								strVal = "";
								break;

							default:
								strVal = cell.getStringCellValue();
								break;
						}
						excelCols.put(keyNm[cell.getColumnIndex()], strVal);
					}
					excelRows.add(excelCols);
				}
				excels.put(wb.getSheetName(i), excelRows);
			}
		}
		catch (Exception ex) {
			logger.error(ex.getMessage(), ex);
			throw ex;
		}
		finally {
			wb.close();
			if (saveFile.exists())
				saveFile.delete();
		}
		return excels;
	}

	/**
	 * 업로드 엑셀이 확장자가 xlsx 일경우
	 *
	 * @param savedFile
	 * @param keyNm
	 * @return
	 * @throws Exception
	 */
	@Deprecated
	private static List<HashMap<String, String>> readExcelXlsx(File savedFile, String[] keyNm) throws Exception {

		XSSFWorkbook wb = new XSSFWorkbook(new FileInputStream(savedFile));

		List<HashMap<String, String>> excelRows = new ArrayList<HashMap<String, String>>();

		try {

			for (int i = 0; i < wb.getNumberOfSheets(); i++) {
				for (Row row : wb.getSheetAt(i)) {
					HashMap<String, String> excelCols = new HashMap<String, String>();
					int cellCnt = 0;
					String strVal = "";
					for (Cell cell : row) {
						switch (cell.getCellType()) {
							case Cell.CELL_TYPE_STRING:
								System.out.print(cell.getRichStringCellValue().getString());
								strVal = cell.getRichStringCellValue().getString();
								break;
							case Cell.CELL_TYPE_NUMERIC:
								if (DateUtil.isCellDateFormatted(cell)) {
									Date dateValue = cell.getDateCellValue();
									SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
									System.out.print(format.format(dateValue)); // 2009-05-29
									strVal = format.format(dateValue);
								} else {
									System.out.print(Double.valueOf(cell.getNumericCellValue()).intValue());
									strVal = Double.valueOf(cell.getNumericCellValue()).intValue() + "";
								}
								break;
							case Cell.CELL_TYPE_FORMULA:
								System.out.print(cell.getCellFormula());
								strVal = cell.getCellFormula();
								break;
							case Cell.CELL_TYPE_BOOLEAN:
								System.out.print(cell.getBooleanCellValue());
								if (cell.getBooleanCellValue()) {
									strVal = "true";
								} else {
									strVal = "false";
								}
								break;
							case Cell.CELL_TYPE_ERROR:
								System.out.print(cell.getErrorCellValue());
								break;
							case Cell.CELL_TYPE_BLANK:
								break;
							default:
								break;
						}
						excelCols.put(keyNm[cellCnt], strVal);
						cellCnt++;
					}
					excelRows.add(excelCols);
				}
			}
		}
		catch (Exception ex) {
			//ex.printStackTrace();
			throw ex;
		}


		return excelRows;
	}

	/**
	 * 업로드 엑셀이 확장자가 xls 일경우
	 *
	 * @param savedFile
	 * @param keyNm
	 * @return
	 * @throws IOException
	 */
	@Deprecated
	private static List<HashMap<String, String>> readExcelXls(File savedFile, String[] keyNm) throws Exception {

		HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(savedFile));

		List<HashMap<String, String>> excelDate = new ArrayList<HashMap<String, String>>();

		try {
			for (int i = 0; i < wb.getNumberOfSheets(); i++) {
				for (Row row : wb.getSheetAt(i)) {

					HashMap<String, String> dateMap = new HashMap<String, String>();
					int cellCnt = 0;
					String strVal = "";

					for (Cell cell : row) {
						switch (cell.getCellType()) {
							case Cell.CELL_TYPE_STRING:
								System.out.print(cell.getRichStringCellValue().getString());
								strVal = cell.getRichStringCellValue().getString();
								break;
							case Cell.CELL_TYPE_NUMERIC:
								if (DateUtil.isCellDateFormatted(cell)) {
									Date dateValue = cell.getDateCellValue();
									SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
									System.out.print(format.format(dateValue)); // 2009-05-29
									strVal = format.format(dateValue);
								} else {
									System.out.print(Double.valueOf(cell.getNumericCellValue()).intValue());
									strVal = Double.valueOf(cell.getNumericCellValue()).intValue() + "";
								}
								break;
							case Cell.CELL_TYPE_FORMULA:
								System.out.print(cell.getCellFormula());
								strVal = cell.getCellFormula();
								break;
							case Cell.CELL_TYPE_BOOLEAN:
								System.out.print(cell.getBooleanCellValue());
								if (cell.getBooleanCellValue()) {
									strVal = "true";
								} else {
									strVal = "false";
								}
								break;
							case Cell.CELL_TYPE_ERROR:
								System.out.print(cell.getErrorCellValue());
								break;
							case Cell.CELL_TYPE_BLANK:
								break;
							default:
								break;
						}
						System.out.print("\t");

						dateMap.put(keyNm[cellCnt], strVal);
						cellCnt++;
					}
					excelDate.add(dateMap);
					System.out.println();
				}
			}
		} catch (Exception ex) {
			//ex.printStackTrace();
			throw ex;
		}

		return excelDate;
	}

}
```

[엑셀 업로드 유틸 참고](https://github.com/sangyoon-kang/lounge/blob/6da2b90f3b2227338bd975b949dcece4ac2302b2/src/main/java/com/tagoplus/util/ExcelUploadUtil.java)
