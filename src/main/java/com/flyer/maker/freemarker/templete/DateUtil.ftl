package ${projectPackage}.utils;

import org.joda.time.DateTime;
import org.joda.time.LocalTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by ${author} on ${.now?string('yyyy/MM/dd')}.
 */
public class DateUtil {

    public static final String FORMAT_DATE = "yyyy-MM-dd";
    public static final String FORMAT_DATETIME = "yyyy-MM-dd HH:mm";
    public static final String FORMAT_TIME = "HH:mm";
    public static final String YYYY = "yyyy";
    public static final String MM = "MM";
    public static final String DD = "dd";

    private DateUtil() {
    }

    /**
     * 字符串转为日期
     *
     * @param input
     * @param pattern the date format patterns to use
     * @return
     */
    public static Date parse(String input, String pattern) {
        DateTimeFormatter fmt = DateTimeFormat.forPattern(pattern);
        DateTime dateTime = fmt.parseDateTime(input);
        return dateTime.toDate();
    }

    /**
     * 日期转为字符串
     *
     * @param date
     * @param pattern
     * @return
     */
    public static String format(Date date, String pattern) {
        DateTimeFormatter fmt = DateTimeFormat.forPattern(pattern);
        return fmt.print(new DateTime(date));
    }

    /**
     * 字符串转为joda日期
     *
     * @param input
     * @param pattern
     * @return
     */
    public static DateTime parseDateTime(String input, String pattern) {
        DateTimeFormatter fmt = DateTimeFormat.forPattern(pattern);
        DateTime dateTime = fmt.parseDateTime(input);
        return dateTime;
    }

    /**
     * joda日期转为字符串
     *
     * @param dateTime
     * @param pattern
     * @return
     */
    public static String format(DateTime dateTime, String pattern) {
        DateTimeFormatter fmt = DateTimeFormat.forPattern(pattern);
        return fmt.print(dateTime);
    }


    /**
     * 时间字符串转为时间
     *
     * @param time
     * @param pattern
     * @return
     */
    public static LocalTime parseTime(String time, String pattern) {
        DateTimeFormatter fmt = DateTimeFormat.forPattern(pattern);
        return fmt.parseLocalTime(time);
    }


    /**
     * getWeek:(根据时间计算星期几，结果为阿拉伯数字). <br/>
     * 例如：
     * 输入：“2015.4.28”
     * 输出：“2”
     *
     * @param date
     * @return
     */
    public static String getWeekArabic(Date date) {
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        int dayForWeek = 0;
        if (c.get(Calendar.DAY_OF_WEEK) == 1) {
            dayForWeek = 7;
        } else {
            dayForWeek = c.get(Calendar.DAY_OF_WEEK) - 1;
        }
        return String.valueOf(dayForWeek);
    }

    /**
     * getWeek:(根据时间计算星期几，结果为文字描述). <br/>
     * 例如：
     * 输入：“2015.4.28”
     * 输出：“星期二”
     *
     * @param date
     * @return
     */
    public static String getWeek(Date date) {
        return new SimpleDateFormat("EEEE").format(date);
    }

    /**
     * 获取指定时间向前或向后多少秒后的时间 负数为向前，正数为向后
     *
     * @param date
     * @param second
     * @return
     */
    public static Date getNextSecond(Date date, int second) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.SECOND, second);
        date = calendar.getTime();
        return date;
    }

    /**
     * 时间对象转换成字符串
     *
     * @param date
     * @param formatStr
     * @return
     */
    public static String date2string(Date date, String formatStr) {
        String strDate = "";
        if (date != null) {
            SimpleDateFormat sdf = new SimpleDateFormat(formatStr);
            strDate = sdf.format(date);
        }
        return strDate;
    }

    public static Date date2date(Date date, String formatStr) {
        SimpleDateFormat sdf = new SimpleDateFormat(formatStr);
        String str = sdf.format(date);
        try {
            date = sdf.parse(str);
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
        return date;
    }

    /**
     * sql时间对象转换成字符串
     *
     * @param timestamp
     * @param formatStr
     * @return
     */
    public static String timestamp2string(Timestamp timestamp, String formatStr) {
        SimpleDateFormat sdf = new SimpleDateFormat(formatStr);
        return sdf.format(timestamp);
    }

    /**
     * 字符串转换成时间对象
     *
     * @param dateString
     * @param formatStr
     * @return
     */
    public static Date string2date(String dateString, String formatStr) {
        Date formateDate = null;
        DateFormat format = new SimpleDateFormat(formatStr);
        try {
            formateDate = format.parse(dateString);
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
        return formateDate;
    }

    /**
     * Date类型转换为Timestamp类型
     *
     * @param date
     * @return
     */
    public static Timestamp date2timestamp(Date date) {
        if (date == null) {
            return null;
        }
        return new Timestamp(date.getTime());
    }

    /**
     * 获得当前年份
     *
     * @return
     */
    public static String getNowYear() {
        SimpleDateFormat sdf = new SimpleDateFormat(YYYY);
        return sdf.format(new Date());
    }

    /**
     * 获得当前月份
     *
     * @return
     */
    public static String getNowMonth() {
        SimpleDateFormat sdf = new SimpleDateFormat(MM);
        return sdf.format(new Date());
    }

    /**
     * 获得当前日期中的日
     *
     * @return
     */
    public static String getNowDay() {
        SimpleDateFormat sdf = new SimpleDateFormat(DD);
        return sdf.format(new Date());
    }

    /**
     * 获取指定时间向前或向后多少小时后的时间 负数为向前，正数为向后
     *
     * @param date
     * @param hour
     * @return
     */
    public static Date getNextHour(Date date, int hour) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.HOUR_OF_DAY, hour);
        date = calendar.getTime();
        return date;
    }

    /**
     * 获取指定时间向前或向后多少月后的时间 负数为向前，正数为向后
     *
     * @param date
     * @param month
     * @return
     */
    public static Date getNextMonth(Date date, int month) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.MONTH, month);
        date = calendar.getTime();
        return date;
    }
}
