# ExcelUtil.java

```java
package com.wind.office.poi;

import com.wind.common.Constants;
import com.wind.common.DateUtil;
import com.wind.common.IoUtil;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

public class ExcelUtil {

    public static void writeExcel(String path, List<Object> list, boolean sign){
        OutputStream out = null;
        Workbook wb = getWorkbook(path, sign);
        try {
            out = new FileOutputStream(path);
            Sheet sheet = wb.createSheet();
            putSheet(sheet, list);
            wb.write(out);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            IoUtil.close(out);
        }
    }

    public static List<List<String>> readExcel(String path, int sheetNum) {
        List<List<String>> listSheet = null;
        Workbook wb = getWorkbook(path, false);
        int sheets = wb.getNumberOfSheets();
        if(sheetNum <= sheets && sheetNum >=0){
            Sheet sheet = wb.getSheetAt(sheetNum);
            System.out.println(sheet.getLastRowNum());
            listSheet = getSheet(sheet);
        }
        return listSheet;
    }

    private static List<List<String>> getSheet(Sheet sheet){
        List<List<String>> list = new ArrayList<>();
        Iterator<Row> rows = sheet.rowIterator();
        while (rows.hasNext()) {
            Row row = rows.next();
            Iterator<Cell> cells = row.cellIterator();
            List<String> rowList = new ArrayList<>();
            while (cells.hasNext()) {
                Cell cell = cells.next();
                if(cell != null) {
                    String value = getCellValue(cell);
                    rowList.add(value);
                }
            }

            list.add(rowList);

        }

        return list;
    }

    private static String getCellValue(Cell cell){
        String value = "";
        if(cell != null) {
            switch (cell.getCellTypeEnum()) {
                case FORMULA:
                    value += cell.getCellFormula();
                    break;

                case NUMERIC:
                    double cellValue = cell.getNumericCellValue();
                    if(HSSFDateUtil.isCellDateFormatted(cell)){
                        Date date = HSSFDateUtil.getJavaDate(cellValue);
                        value += DateUtil.format(date, DateUtil.DATE_TIME);
                    }else{
                        value += cell.getNumericCellValue();
                    }
                    break;

                case STRING:
                    value += cell.getStringCellValue();
                    break;
                case BLANK:
                    break;
                case BOOLEAN:
                    value += cell.getBooleanCellValue();
                    break;
                case ERROR:
                    break;
                default:break;
            }
        }
        return value;
    }

    private static void putSheet(Sheet sheet, List<Object> list){
        Row row;
        Cell c;
        if(sheet != null && list != null){
            for(int i = 0; i < list.size(); i++){
                row =  sheet.createRow(i);
                Object obj = list.get(i);
                if(obj instanceof List){
                    List rowData = (List) obj;
                    for(int j = 0; j < rowData.size(); j++){
                        Object colData = rowData.get(j);
                        c = row.createCell(j);
                        String value = colData != null ? colData.toString() : "";
                        if(colData instanceof String){
                            c.setCellValue(value);
                        }
                    }
                }
            }
        }
    }

    private static Workbook getWorkbook(String path, boolean sign){
        Workbook wb = null;
        InputStream input = null;
        try {
            if(sign){
                if(path.endsWith(Constants.EXCEL_XLS)){
                    //2003-2007
                    wb = new HSSFWorkbook();
                }else{
                    //2007+
                    wb = new XSSFWorkbook();
                }
            }else{
                input = new FileInputStream(path);
                if(path.endsWith(Constants.EXCEL_XLSX)){
                    //2007+
                    wb = new XSSFWorkbook(input);
                }else{
                    //2003-2007
                    wb = new HSSFWorkbook(input);
                }
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }finally{
            IoUtil.close(input);
        }
        return wb;
    }
}
```