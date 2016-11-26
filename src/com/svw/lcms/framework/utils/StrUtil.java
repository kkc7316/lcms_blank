package com.svw.lcms.framework.utils;

public class StrUtil {

    private StrUtil() {
    }
    
    
    
   /**
     * <p>Description: 把一个字符串的末尾移走n个字符</p>
     * @param full
     * @param end
     * @return
     */
    public static String removeByEndStr(String fullString, String endString) {
        
        String result;
        result = fullString.substring(0, fullString.length() - endString.length());
        
        return result;
    }
    
     
}
