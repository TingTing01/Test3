package com.tourcan.att.controller;

import java.io.BufferedReader;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.tourcan.att.model.AttDAO;
import com.tourcan.att.model.AttVO;

@WebServlet("/HotelServlet")
public class AttServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AttServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		BufferedReader br = request.getReader();
		StringBuffer sb = new StringBuffer(128);
		String json;
		while ((json = br.readLine()) != null)
			sb.append(json);
		json = sb.toString();
		// System.out.println(json);

		JSONObject err = new JSONObject(); // checking result
		try {
			JSONObject obj = new JSONObject(json); // received and parsed JSON
			AttVO vo = new AttVO();

			try {
				String attName = obj.getString("attName");
				if (attName == null || attName.trim().isEmpty() || attName.trim().length() >= 50) {
					throw new Exception();
				}
				vo.setAtt_name(attName);
			} catch (Exception e) {
				err.append("attName", "無效的景點名稱。");
//				e.printStackTrace();
			}

			try {
				Integer regionId = obj.getInt("regionId");
				if (regionId == null || regionId < 0) {
					throw new Exception();
				}
				vo.setRegion_id(regionId);
			} catch (Exception e) {
				err.append("regionId", "無效的地區代號。");
//				e.printStackTrace();
			}

			try {
				String attAddr = obj.getString("attAddr");
				if (attAddr == null || attAddr.trim().isEmpty()) {
					throw new Exception();
				}
				vo.setAtt_addr(attAddr);
			} catch (Exception e) {
				err.append("attAddr", "無效的景點地址。");
//				e.printStackTrace();
			}

			try {
				Boolean attEat = obj.getBoolean("attEat");
				vo.setAtt_eat(attEat);
			} catch (Exception e) {
				err.append("attAddr", "無效的吃貨屬性。");
//				e.printStackTrace();
			}

			try {
				String attIntro = obj.getString("attIntro");
				if (attIntro == null || attIntro.trim().isEmpty()) {
					throw new Exception();
				}
				vo.setAtt_intro(attIntro);
			} catch (Exception e) {
				err.append("attIntro", "無效的景點介紹。");
//				e.printStackTrace();
			}

			try {
				String appOpen = obj.getString("attOpen");
				if (appOpen == null || appOpen.trim().isEmpty()) {
					throw new Exception();
				}
				vo.setAtt_open(appOpen);
			} catch (Exception e) {
				err.append("attOpen", "無效的開放資訊。");
//				e.printStackTrace();
			}

			try {
				String attPhone = obj.getString("attPhone");
				if (attPhone == null || attPhone.trim().isEmpty() || attPhone.trim().length() >= 50) {
					throw new Exception();
				}
				vo.setAtt_phone(attPhone);
			} catch (Exception e) {
				err.append("attPhone", "無效的聯絡電話。");
//				e.printStackTrace();
			}

			try {
				Double attPrice = obj.getDouble("attPrice");
				if (attPrice == null || attPrice < 0) {
					throw new Exception();
				}
				vo.setAtt_price(attPrice);
			} catch (Exception e) {
				err.append("attPrice", "無效的基本消費。");
//				e.printStackTrace();
			}

			try {
				Integer attStaytime = obj.getInt("attStaytime");
				if (attStaytime == null || attStaytime < -1) {
					throw new Exception();
				}
				vo.setAtt_staytime(attStaytime);
			} catch (Exception e) {
				err.append("attStaytime", "無效的滯留時間。");
//				e.printStackTrace();
			}

			try {
				String attUrl = obj.getString("attUrl");
				if (attUrl == null || attUrl.trim().isEmpty()) {
					throw new Exception();
				}
				vo.setAtt_url(attUrl);
			} catch (Exception e) {
				err.append("attUrl", "無效的景點網址。");
//				e.printStackTrace();
			}

			try {
				Double attLat = obj.getDouble("attLat");
				if (attLat == null || attLat < -90 || attLat > 90) {
					throw new Exception();
				}
				vo.setAtt_lat(attLat);
			} catch (Exception e) {
				err.append("attLat", "無效的緯度。");
//				e.printStackTrace();
			}

			try {
				Double attLng = obj.getDouble("attLng");
				if (attLng == null || attLng < -180 || attLng > 180) {
					throw new Exception();
				}
				vo.setAtt_lng(attLng);
			} catch (Exception e) {
				err.append("attLng", "無效的經度。");
//				e.printStackTrace();
			}

			if (err.length() > 0) {
				throw new Exception();
			} else {
				AttDAO dao = new AttDAO();
				dao.insert(vo);
			}
		} catch (Exception e) {
			err.append("result", "新增失敗。");
//			e.printStackTrace();
		}
		
		response.getWriter().println(err.toString());

		// // test output
		// for (String key : JSONObject.getNames(obj)) {
		// System.out.println(key+"\t"+obj.getString(key));
		// for (String key2 : JSONObject.getNames(obj.getJSONObject(key1))) {
		// System.out.println(" " + key2);
		// }
		// }
		//
		// // test output
		// System.out.println("\n" + sb.toString());
		// Enumeration<String> headers = request.getHeaderNames();
		// while (headers.hasMoreElements()) {
		// String header = headers.nextElement();
		// System.out.println(header + "\t: " + request.getHeader(header));
		// }
	}

	protected void doPut(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doDelete(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

}
