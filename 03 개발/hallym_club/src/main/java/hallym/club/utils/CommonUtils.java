package hallym.club.utils;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.imgscalr.Scalr;

public class CommonUtils {

	public static final String SAVE_PATH = "/home/club/files/upload";
	public static final String PREFIX_URL = "/home/club/files/upload/";
	public static final String SAVE_THUMBNAIL_PATH = "/home/club/upload/thumbnail";
	
	
//	public static String getUTF8(String str) {
//		
//		try {
//			str = new String(str.getBytes("ISO-8859-1"), "UTF-8");
//		} catch (UnsupportedEncodingException e) {
//			System.err.println("[CommonUtils.java] str Error: " + e.getMessage());
//		} 
//		return str;
//		
//	}
	
	public static String getRandomString() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
	
	public static String uploadFile(String originalName) {
		String savedName = null;
		if(originalName.isEmpty() || originalName == null) {
			savedName = "";
		}else {
			UUID uuid = UUID.randomUUID();
			savedName = uuid.toString()+"_"+originalName;
			
		}
		return savedName;
	}
	
	public static String getTimeBasePath() {
		String str = "/";
		
		Calendar calendar = Calendar.getInstance();
		int year = calendar.get(Calendar.YEAR);
		int month = calendar.get(Calendar.MONTH) + 1;
		int day = calendar.get(Calendar.DATE);
//		str += calendar.get(Calendar.YEAR);
//		str += "/";
//		str += calendar.get(Calendar.MONTH+1);
//		str += "/";
//		str += calendar.get(Calendar.DATE);
//		str += calendar.get(Calendar.HOUR);
//		str += calendar.get(Calendar.MINUTE);
//		str += calendar.get(Calendar.SECOND);
//		str += calendar.get(Calendar.MILLISECOND);
//		str += "/";

		str = "/" + year + "/" + month + "/" + day;
		System.err.println("[CommonUtils] year: " + year);
		System.err.println("[CommonUtils] month: " + month);
		System.err.println("[CommonUtils] day: " + day);
		System.err.println("[CommonUtils] str: " + str);
		return str;
	}
	
	public static String getExtension(String fileName) {
		return FilenameUtils.getExtension(fileName);
//		return fileName.substring(fileName.lastIndexOf("."), fileName.length());
	}
	
	public static String getMD5(byte[] str) {
		String MD5 = "";
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(str);
			byte byteData[] = md.digest();
			StringBuffer sb = new StringBuffer(); 
			for(int i = 0 ; i < byteData.length ; i++) {
				sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
			}
			MD5 = sb.toString();
		} catch(NoSuchAlgorithmException e) {
			e.printStackTrace();
			MD5 = null;
		}
		
		return MD5;
	}
	public static String getMD5(String str) {
		String MD5 = "";
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(str.getBytes());
			byte byteData[] = md.digest();
			StringBuffer sb = new StringBuffer(); 
			for(int i = 0 ; i < byteData.length ; i++) {
				sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
			}
			MD5 = sb.toString();
		} catch(NoSuchAlgorithmException e) {
			e.printStackTrace();
			MD5 = null;
		}
		
		return MD5;
	}

	public static String getSHA256(byte[] str) {
		String SHA = "";
		try {
			MessageDigest sh = MessageDigest.getInstance("SHA-256");
			sh.update(str);
			byte byteData[] = sh.digest();
			StringBuffer sb = new StringBuffer();
			for(int i = 0 ; i < byteData.length ; i++) {
				sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
			}
			SHA = sb.toString();
		} catch(NoSuchAlgorithmException e) {
			e.printStackTrace();
			SHA = null;
		}
		
		return SHA;
	}
	public static String getSHA256(String str) {
		String SHA = "";
		try {
			MessageDigest sh = MessageDigest.getInstance("SHA-256");
			sh.update(str.getBytes());
			byte byteData[] = sh.digest();
			StringBuffer sb = new StringBuffer();
			for(int i = 0 ; i < byteData.length ; i++) {
				sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
			}
			SHA = sb.toString();
		} catch(NoSuchAlgorithmException e) {
			e.printStackTrace();
			SHA = null;
		}
		
		return SHA;
	}
	
	public static void showAlert(HttpServletResponse response, String msg) {
		response.setContentType("text/html; charset=UTF-8");
        PrintWriter out;
		try {
			out = response.getWriter();
			out.println("<script>");
			out.println("alert('" + msg + "');");
			out.println("window.close();");
			out.println("</script>");
	        out.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void showAlert(HttpServletResponse response, String msg, String link) {
		response.setContentType("text/html; charset=UTF-8");
        PrintWriter out;
		try {
			out = response.getWriter();
			out.println("<script>");
			out.println("alert('" + msg + "');");
			out.println("location.href='" + link + "';");
			out.println("window.close();");
			out.println("</script>");
	        out.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void showAlertNoClose(HttpServletResponse response, String msg, String link) {
		response.setContentType("text/html; charset=UTF-8");
        PrintWriter out;
		try {
			out = response.getWriter();
			out.println("<script>");
			out.println("alert('" + msg + "');");
			out.println("location.href='" + link + "';");
			out.println("</script>");
	        out.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void showAlertHistoryBack(HttpServletResponse response, String msg) {
		response.setContentType("text/html; charset=UTF-8");
        PrintWriter out;
		try {
			out = response.getWriter();
			out.println("<script>");
			out.println("alert('" + msg + "');");
			out.println("history.back();");
			out.println("window.close();");
			out.println("</script>");
	        out.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static void windowClose(HttpServletResponse response, String msg) {
		response.setContentType("text/html; charset=UTF-8");
        PrintWriter out;
		try {
			out = response.getWriter();
			out.println("<script>");
			out.println("alert('" + msg + "');");
			out.println("self.close();");
			out.println("</script>");
	        out.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static boolean createThumbnail(String path, String saveFileName) {
		boolean ret = false;
		String fullPath = path + "/" + saveFileName;
		File dir = new File(fullPath);
        if (!dir.exists() || !dir.isFile()) {
            // error
        	return ret;
        }
		
        try {
			// 저장된 원본파일로부터 BufferedImage 객체를 생성합니다.
			BufferedImage srcImg = ImageIO.read(dir);
	
			// 썸네일의 너비와 높이 입니다.
			int dw = 285, dh = 285;
			
			// 원본 이미지의 너비와 높이 입니다.
			int ow = srcImg.getWidth();
			int oh = srcImg.getHeight();
			
			// 원본 너비를 기준으로 하여 썸네일의 비율로 높이를 계산합니다.
			int nw = ow;
			int nh = (ow * dh) / dw;
			
			// 계산된 높이가 원본보다 높다면 crop이 안되므로
			// 원본 높이를 기준으로 썸네일의 비율로 너비를 계산합니다.
			if(nh > oh) {
				nw = (oh * dw) / dh;
				nh = oh;
			}
			
			// 계산된 크기로 원본이미지를 가운데에서 crop 합니다.
			BufferedImage cropImg = Scalr.crop(srcImg, (ow-nw)/2, (oh-nh)/2, nw, nh);
			
			// crop된 이미지로 썸네일을 생성합니다.
			BufferedImage destImg = Scalr.resize(cropImg, dw, dh);
			
			// 썸네일을 저장합니다.
			ImageIO.write(destImg, getExtension(saveFileName), dir);
			ret = true;
        } catch (IOException e) {
        	ret = false;
        	e.printStackTrace();
        }
        return ret;
	}
	
	public static String getClientIP(HttpServletRequest request) {
	    String ip = request.getHeader("X-Forwarded-For");
//	    System.out.println("> X-FORWARDED-FOR : " + ip);

	    if (ip == null) {
	        ip = request.getHeader("Proxy-Client-IP");
//	        System.out.println("> Proxy-Client-IP : " + ip);
	    }
	    if (ip == null) {
	        ip = request.getHeader("WL-Proxy-Client-IP");
//	        System.out.println(">  WL-Proxy-Client-IP : " + ip);
	    }
	    if (ip == null) {
	        ip = request.getHeader("HTTP_CLIENT_IP");
//	        System.out.println("> HTTP_CLIENT_IP : " + ip);
	    }
	    if (ip == null) {
	        ip = request.getHeader("HTTP_X_FORWARDED_FOR");
//	        System.out.println("> HTTP_X_FORWARDED_FOR : " + ip);
	    }
	    if (ip == null) {
	        ip = request.getRemoteAddr();
//	        System.out.println("> getRemoteAddr : "+ip);
	    }
//	    System.out.println("> Result : IP Address : "+ip);

	    return ip;
	}
}
