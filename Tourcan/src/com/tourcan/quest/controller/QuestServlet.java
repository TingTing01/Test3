package com.tourcan.quest.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.google.gson.Gson;
import com.tourcan.mem.model.MemVO;
import com.tourcan.quest.model.QuestService;
import com.tourcan.quest.model.QuestVO;

@WebServlet("/quest/QuestServlet")
public class QuestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public QuestServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		String method = request.getParameter("method");

		// ----------------findById----------------
		if (method.equals("getOneById")) {
			JSONObject checkResult = new JSONObject();
			Integer questId = null;
			QuestVO questVO = null;

			try {
				String id = request.getParameter("questId");
				// System.out.println(id);
				if (id == null || id.trim().length() == 0) {
					checkResult.append("checkResult", "請輸入問題ID");
				} else {
					try {
						questId = new Integer(id);
					} catch (Exception e) {
						// e.printStackTrace();
						checkResult.append("checkResult", "問題ID格式不正確");
					}
				}
				QuestService questSvc = new QuestService();
				questVO = questSvc.findById(questId);
				if (questVO != null) {
					JSONObject obj = new JSONObject(questVO);
					response.getWriter().println(obj.toString());
				} else {
					checkResult.append("checkResult", "查無資料");
					response.getWriter().println(checkResult.toString());
				}
			} catch (Exception e) {
				checkResult.append("false", "查詢失敗");
				response.getWriter().println(checkResult.toString());
			}
		}

		// ----------------findByName----------------

		String questTopic = request.getParameter("questTopic");
		List<QuestVO> questVO = null;

		if (method.equals("getByName")) {
			JSONObject checkResult = new JSONObject();
			try {
				if (questTopic == null || questTopic.trim().length() == 0)
					checkResult.append("result", "請輸入問題名稱");

				if (checkResult.length() > 0) {
					throw new Exception();
				} else {
					QuestService questSvc = new QuestService();
					questVO = questSvc.findByName(questTopic);
					if (questVO.size() != 0) {
						Gson gson = new Gson();
						String jsonG = gson.toJson(questVO);
						// System.out.println(jsonG);
						response.getWriter().println(jsonG);
					} else {
						checkResult.append("result", "查無資料");
						response.getWriter().println(checkResult.toString());
					}
				}
				// ***************************其他可能的錯誤處理*************************************//*
			} catch (Exception e) {
				checkResult.append("result", "查詢失敗");
				System.out.println("err=" + checkResult);
				response.getWriter().println(checkResult.toString());
			}
		}
		// ----------------findByUid----------------

		String memUid = request.getParameter("memUid");
//		List<QuestVO> questVO = null;

		if (method.equals("getAllByUid")) {
			JSONObject checkResult = new JSONObject();
			try {
				if (memUid == null || memUid.trim().length() == 0)
					checkResult.append("checkResult", "請輸入memUid");

				if (checkResult.length() > 0) {
					throw new Exception();
				} else {
					QuestService questSvc = new QuestService();
					questVO = questSvc.findByUid(memUid);
					if (questVO.size() != 0) {
						Gson gson = new Gson();
						String jsonG = gson.toJson(questVO);
						// System.out.println(jsonG);
						response.getWriter().println(jsonG);
					} else {
						checkResult.append("checkResult", "查無資料");
						response.getWriter().println(checkResult.toString());
					}
				}
			} catch (Exception e) {
				checkResult.append("result", "查詢失敗");
				System.out.println("err=" + checkResult);
				response.getWriter().println(checkResult.toString());
			}
		}

		// ----------------getAll----------------

		if (method.equals("getAll")) {
			JSONObject checkResult = new JSONObject();
			try {
				QuestService questSvc = new QuestService();
				questVO = questSvc.getAll();
				if (questVO.size() != 0) {
					Gson gson = new Gson();
					String jsonG = gson.toJson(questVO);
					// System.out.println(jsonG);
					response.getWriter().println(jsonG);
				}
				// ***************************其他可能的錯誤處理*************************************//*
			} catch (Exception e) {
				checkResult.append("result", "查詢失敗");
				System.out.println("err=" + checkResult);
				response.getWriter().println(checkResult.toString());
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// ----------------INSERT----------------
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		BufferedReader br = request.getReader();

		Integer questCatalog = null;
		String questTopic = null;
		String memUid = null;
		String questQuiz = null;
		Integer adminId = null;
		String questReply = null;
		Timestamp questQtime = null;
		Timestamp questRtime = null;

		JSONObject checkResult = new JSONObject(); // checking result
		QuestVO questVO = null;
		try {
			questVO = new Gson().fromJson(br, QuestVO.class);

			questCatalog = questVO.getQuest_catalog();
			if (questCatalog == null || questCatalog < 0)
				checkResult.append("getQuest_catalog", "問題分類錯誤。");

			questTopic = questVO.getQuest_topic();
			if (questTopic == null || questTopic.trim().isEmpty()) {
				checkResult.append("getQuest_topic", "請輸入問題名稱。");
			} else if (questTopic.trim().length() >= 50) {
				checkResult.append("getQuest_topic", "問題名稱不得超過50個字");
			}

//			memUid = questVO.getMem_uid();
//			if (memUid == null || memUid.trim().isEmpty())
//				checkResult.append("getMem_uid", "會員ID錯誤。");

			questQuiz = questVO.getQuest_quiz();
			if (questQuiz == null || questQuiz.trim().isEmpty())
				checkResult.append("getQuest_quiz", "問題內容錯誤。");

			// adminId = questVO.getAdmin_id();
			// if (adminId == null || adminId < 0)
			// checkResult.append("getAdmin_id", "管理員ID錯誤。");

			// questReply = questVO.getQuest_reply();
			// if (questReply == null || questReply.trim().isEmpty())
			// checkResult.append("getQuest_reply", "問題回覆錯誤。");

			// 抓出建立當下時間
			questQtime = new Timestamp(System .currentTimeMillis());
			MemVO memVO=(MemVO) request.getSession().getAttribute("vo");
			memUid = memVO.getMem_uid();
			adminId = null;
			questReply = null;
			questRtime = null;

			// memUid = questVO.getMem_uid(); // 抓出建立會員Id 且 不能修改
//			adminId = 1
					; // 抓出回覆管理員Id 且 不能修改

			if (checkResult.length() > 0) {
				throw new Exception();
			} else {
				QuestService srv = new QuestService();
				srv.insertQuest(questCatalog, questTopic, memUid, questQuiz, adminId, questReply, questQtime,
						questRtime);
				checkResult.append("result", "新增成功");
				response.getWriter().println(checkResult.toString());
			}
		} catch (Exception e) {
			checkResult.append("result", "新增失敗");
			response.getWriter().println(checkResult.toString());
			e.printStackTrace();
		}
	}

	protected void doDelete(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// ----------------DELETE----------------
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");

		Integer questId = null;

		/***************************** 刪除一筆資料 ************************************************************************/

		Map<String, String> errorMsgs = new HashMap<>();
		/****************************
		 * 1.接收請求參數 - 輸入格式的錯誤處理
		 **********************/
		try {
			String id = request.getParameter("questId");
			System.out.println(id);
			if (id == null || (id.trim()).length() == 0) {
				errorMsgs.put("errMsg", "請輸入問題ID");
			} else {
				try {
					questId = new Integer(id);
				} catch (Exception e) {
					errorMsgs.put("errMsg", "問題ID格式不正確");
				}
			}

			/*************************** 2.開始刪除單筆資料 *****************************************/
			QuestService srv = new QuestService();
			try {
				srv.deleteQuest(questId);
			} catch (Exception e) {
				errorMsgs.put("errMsg", "查無資料");
			}

			/*************************** 其他可能的錯誤處理 **************************************/
		} catch (Exception e) {
			errorMsgs.put("errMsg", "無法取得資料:" + e.getMessage());
		}
		JSONObject json = new JSONObject(errorMsgs);
		response.getWriter().println(json.toString());
	}
}
