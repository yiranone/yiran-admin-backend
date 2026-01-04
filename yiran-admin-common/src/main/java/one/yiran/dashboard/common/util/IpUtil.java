package one.yiran.dashboard.common.util;

import lombok.extern.slf4j.Slf4j;
import one.yiran.dashboard.common.constants.Global;
import one.yiran.dashboard.common.ip.IPLocation;
import one.yiran.dashboard.common.ip.IPLocationV6;
import one.yiran.dashboard.common.ip.Location;
import org.apache.commons.lang3.StringUtils;

import javax.servlet.http.HttpServletRequest;

@Slf4j
public class IpUtil {
    public static String getIpAddr(HttpServletRequest request) {
        return one.yiran.common.util.IpUtil.getRemoteAddr(request);
    }

    public static boolean internalIp(String ip) {
        byte[] addr = textToNumericFormatV4(ip);
        if (addr == null || addr.length < 2)
            return false;
        return internalIp(addr) || "127.0.0.1".equals(ip);
    }

    private static boolean internalIp(byte[] addr) {
        final byte b0 = addr[0];
        final byte b1 = addr[1];
        // 10.x.x.x/8
        final byte SECTION_1 = 0x0A;
        // 172.16.x.x/12
        final byte SECTION_2 = (byte) 0xAC;
        final byte SECTION_3 = (byte) 0x10;
        final byte SECTION_4 = (byte) 0x1F;
        // 192.168.x.x/16
        final byte SECTION_5 = (byte) 0xC0;
        final byte SECTION_6 = (byte) 0xA8;
        switch (b0) {
            case SECTION_1:
                return true;
            case SECTION_2:
                if (b1 >= SECTION_3 && b1 <= SECTION_4) {
                    return true;
                }
            case SECTION_5:
                switch (b1) {
                    case SECTION_6:
                        return true;
                }
            default:
                return false;
        }
    }

    /**
     * 将IPv4地址转换成字节
     *
     * @param text IPv4地址
     * @return byte 字节
     */
    public static byte[] textToNumericFormatV4(String text) {
        if (text.length() == 0) {
            return null;
        }

        byte[] bytes = new byte[4];
        String[] elements = text.split("\\.", -1);
        try {
            long l;
            int i;
            switch (elements.length) {
                case 1:
                    l = Long.parseLong(elements[0]);
                    if ((l < 0L) || (l > 4294967295L))
                        return null;
                    bytes[0] = (byte) (int) (l >> 24 & 0xFF);
                    bytes[1] = (byte) (int) ((l & 0xFFFFFF) >> 16 & 0xFF);
                    bytes[2] = (byte) (int) ((l & 0xFFFF) >> 8 & 0xFF);
                    bytes[3] = (byte) (int) (l & 0xFF);
                    break;
                case 2:
                    l = Integer.parseInt(elements[0]);
                    if ((l < 0L) || (l > 255L))
                        return null;
                    bytes[0] = (byte) (int) (l & 0xFF);
                    l = Integer.parseInt(elements[1]);
                    if ((l < 0L) || (l > 16777215L))
                        return null;
                    bytes[1] = (byte) (int) (l >> 16 & 0xFF);
                    bytes[2] = (byte) (int) ((l & 0xFFFF) >> 8 & 0xFF);
                    bytes[3] = (byte) (int) (l & 0xFF);
                    break;
                case 3:
                    for (i = 0; i < 2; ++i) {
                        l = Integer.parseInt(elements[i]);
                        if ((l < 0L) || (l > 255L))
                            return null;
                        bytes[i] = (byte) (int) (l & 0xFF);
                    }
                    l = Integer.parseInt(elements[2]);
                    if ((l < 0L) || (l > 65535L))
                        return null;
                    bytes[2] = (byte) (int) (l >> 8 & 0xFF);
                    bytes[3] = (byte) (int) (l & 0xFF);
                    break;
                case 4:
                    for (i = 0; i < 4; ++i) {
                        l = Integer.parseInt(elements[i]);
                        if ((l < 0L) || (l > 255L))
                            return null;
                        bytes[i] = (byte) (int) (l & 0xFF);
                    }
                    break;
                default:
                    return null;
            }
        } catch (NumberFormatException e) {
            return null;
        }
        return bytes;
    }

    public static String getRealAddressByIP(String ip) {
        if (StringUtils.isBlank(ip)) {
            return "";
        }
        String address = "XX";
        // 内网不查询
        if (IpUtil.internalIp(ip)) {
            return "内网IP";
        }
        if (Global.isAddressEnabled()) {
            try {
                Location lo = null;
                if(StringUtils.contains(ip,":")) {
                    lo = IPLocationV6.fetchIP(ip);
                } else {
                    lo = IPLocation.fetchIP(ip);
                }
                if(lo != null) {
                    address = lo.country + "|" + lo.area;
                }
            } catch (Exception e) {
                log.error("获取IP信息异常",e);
            }
        }
        return address;
    }

    public static void main(String[] args) throws Exception {
        String ipl = "/Users/jingjingzhong/space/yiran/yiran-backend/yiran-admin-common/src/main/resources/data/qqwry.dat";
        Location lo = IPLocation.fetchIP(ipl,"90.27.189.74");
        if(lo != null) {
            System.out.println(lo);
        }

        String iplv6 = "/Users/jingjingzhong/space/yiran/yiran-backend/yiran-admin-common/src/main/resources/data/ipv6wry.db";
        Location lov6 = IPLocationV6.fetchIP(iplv6, "2408:840d:af00:6d37:1ca6:547d:4b44:a83");
        if(lov6 != null) {
            System.out.println(lov6);
        }
    }
}
