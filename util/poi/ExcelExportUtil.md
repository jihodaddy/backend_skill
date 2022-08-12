# ExcelExport Util
```java
package t5750.poi.util;

import java.io.*;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import t5750.poi.domain.Book;
import t5750.poi.domain.Student;

public class ExcelExportUtil<T> {
	public void exportExcel(Collection<T> dataset, OutputStream out) {
		exportExcel(Globals.SHEETNAME, null, dataset, out, "yyyy-MM-dd");
	}

	public void exportExcel(String[] headers, Collection<T> dataset,
			OutputStream out) {
		exportExcel(Globals.SHEETNAME, headers, dataset, out, "yyyy-MM-dd");
	}

	public void exportExcel(String[] headers, Collection<T> dataset,
			OutputStream out, String pattern) {
		exportExcel(Globals.SHEETNAME, headers, dataset, out, pattern);
	}

	@SuppressWarnings("unchecked")
	public void exportExcel(String title, String[] headers,
			Collection<T> dataset, OutputStream out, String pattern) {
		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFSheet sheet = workbook.createSheet(title);
		sheet.setDefaultColumnWidth((short) 15);
		HSSFCellStyle style = workbook.createCellStyle();
		
        style.setFillForegroundColor(HSSFColor.HSSFColorPredefined.SKY_BLUE.getIndex());
		style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		style.setBorderBottom(BorderStyle.THIN);
		style.setBorderLeft(BorderStyle.THIN);
		style.setBorderRight(BorderStyle.THIN);
		style.setBorderTop(BorderStyle.THIN);
		style.setAlignment(HorizontalAlignment.CENTER);
		
        HSSFFont font = workbook.createFont();
		font.setColor(HSSFColor.HSSFColorPredefined.VIOLET.getIndex());
		font.setFontHeightInPoints((short) 12);
		font.setBold(true);
		
		style.setFont(font);
		
        HSSFCellStyle style2 = workbook.createCellStyle();
		style2.setFillForegroundColor(HSSFColor.HSSFColorPredefined.LIGHT_YELLOW.getIndex());
		style2.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		style2.setBorderBottom(BorderStyle.THIN);
		style2.setBorderLeft(BorderStyle.THIN);
		style2.setBorderRight(BorderStyle.THIN);
		style2.setBorderTop(BorderStyle.THIN);
		style2.setAlignment(HorizontalAlignment.CENTER);
		style2.setVerticalAlignment(VerticalAlignment.CENTER);
	
		HSSFFont font2 = workbook.createFont();
		font2.setBold(false);
	
		style2.setFont(font2);
	
		HSSFPatriarch patriarch = sheet.createDrawingPatriarch();
	
		HSSFComment comment = patriarch.createComment(
				new HSSFClientAnchor(0, 0, 0, 0, (short) 4, 2, (short) 6, 5));
	
		comment.setString(new HSSFRichTextString("可以在POI中添加注释！"));
	
		comment.setAuthor("leno");
	
		HSSFRow row = sheet.createRow(0);
		for (short i = 0; i < headers.length; i++) {
			HSSFCell cell = row.createCell(i);
			cell.setCellStyle(style);
			HSSFRichTextString text = new HSSFRichTextString(headers[i]);
			cell.setCellValue(text);
		}
		Iterator<T> it = dataset.iterator();
		int index = 0;
		while (it.hasNext()) {
			index++;
			row = sheet.createRow(index);
			T t = (T) it.next();
		
			Field[] fields = t.getClass().getDeclaredFields();
			for (short i = 0; i < fields.length; i++) {
				HSSFCell cell = row.createCell(i);
				cell.setCellStyle(style2);
				Field field = fields[i];
				String fieldName = field.getName();
				String getMethodName = "get"
						+ fieldName.substring(0, 1).toUpperCase()
						+ fieldName.substring(1);
				try {
					Class tCls = t.getClass();
					Method getMethod = tCls.getMethod(getMethodName,
							new Class[] {});
					Object value = getMethod.invoke(t, new Object[] {});
					String textValue = null;
					if (null == value) {
						value = "";
					}
					if (value instanceof Boolean) {
						boolean bValue = (Boolean) value;
						textValue = "男";
						if (!bValue) {
							textValue = "女";
						}
					} else if (value instanceof Date) {
						Date date = (Date) value;
						SimpleDateFormat sdf = new SimpleDateFormat(pattern);
						textValue = sdf.format(date);
					} else if (value instanceof byte[]) {
				
						row.setHeightInPoints(60);
				
						sheet.setColumnWidth(i, (short) (35.7 * 80));
				
						byte[] bsValue = (byte[]) value;
						HSSFClientAnchor anchor = new HSSFClientAnchor(0, 0,
								1023, 255, (short) 6, index, (short) 6, index);
						anchor.setAnchorType(
								ClientAnchor.AnchorType.MOVE_DONT_RESIZE);
						patriarch.createPicture(anchor, workbook.addPicture(
								bsValue, HSSFWorkbook.PICTURE_TYPE_JPEG));
					} else {
						textValue = value.toString();
					}
					if (textValue != null) {
						Pattern p = Pattern.compile("^//d+(//.//d+)?$");
						Matcher matcher = p.matcher(textValue);
						if (matcher.matches()) {
							cell.setCellValue(Double.parseDouble(textValue));
						} else {
							HSSFRichTextString richString = new HSSFRichTextString(
									textValue);
							HSSFFont font3 = workbook.createFont();
							font3.setColor(HSSFColor.HSSFColorPredefined.BLUE.getIndex());
							richString.applyFont(font3);
							cell.setCellValue(richString);
						}
					}
				} catch (SecurityException e) {
					e.printStackTrace();
				} catch (NoSuchMethodException e) {
					e.printStackTrace();
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				} catch (InvocationTargetException e) {
					e.printStackTrace();
				} finally {
				}
			}
		}
		try {
			workbook.write(out);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void export2003(String imagesPath, String docsPath) {
		ExcelExportUtil<Student> ex = new ExcelExportUtil<Student>();
		String[] headers = { "学号", "姓名", "年龄", "性别", "出生日期" };
		List<Student> dataset = new ArrayList<Student>();
		dataset.add(new Student(10000001L, "张三", 20, true, new Date()));
		dataset.add(new Student(20000002L, "李四", 24, false, new Date()));
		dataset.add(new Student(30000003L, "王五", 22, true, new Date()));
		
        ExcelExportUtil<Book> exBook = new ExcelExportUtil<Book>();
		String[] headersBook = { "图书编号", "图书名称", "图书作者", "图书价格", "图书ISBN",
				"图书出版社", "封面图片" };
		List<Book> datasetBook = new ArrayList<Book>();
		try {
			Resource resource = new ClassPathResource(imagesPath);
			InputStream is = resource.getInputStream();
			BufferedInputStream bis = new BufferedInputStream(is);
			byte[] buf = new byte[bis.available()];
			while ((bis.read(buf)) != -1) {
				//
			}
			datasetBook.add(new Book(1, "jsp", "leno", 300.33f, "1234567",
					"清华出版社", buf));
			datasetBook.add(new Book(2, "java编程思想", "brucl", 300.33f, "1234567",
					"阳光出版社", buf));
			datasetBook.add(new Book(3, "DOM艺术", "lenotang", 300.33f, "1234567",
					"清华出版社", buf));
			datasetBook.add(new Book(4, "c++经典", "leno", 400.33f, "1234567",
					"清华出版社", buf));
			datasetBook.add(new Book(5, "c#入门", "leno", 300.33f, "1234567",
					"汤春秀出版社", buf));
			OutputStream out = new FileOutputStream(
					docsPath + File.separator + Globals.EXPORT_STUDENT);
			OutputStream outBook = new FileOutputStream(
					docsPath + File.separator + Globals.EXPORT_BOOK);
			ex.exportExcel(headers, dataset, out);
			exBook.exportExcel(headersBook, datasetBook, outBook);
			out.close();
			outBook.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void export2007(String filePath) {
		try {
			
			OutputStream os = new FileOutputStream(filePath);
			
			XSSFWorkbook wb = new XSSFWorkbook();
			XSSFSheet sheet = wb.createSheet(Globals.SHEETNAME);
			for (int i = 0; i < 1000; i++) {
				XSSFRow row = sheet.createRow(i);
			
				row.createCell(0).setCellValue("column" + i);
			
				row.createCell(1).setCellValue("column" + i);
			
            }
			wb.write(os);
			os.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
```