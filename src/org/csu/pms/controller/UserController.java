package org.csu.pms.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.csu.pms.domain.PageVO;
import org.csu.pms.domain.User;
import org.csu.pms.service.PmsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;

@Controller
public class UserController {
	@Autowired
	@Qualifier("pmsService")
	private PmsService pmsService;

	@RequestMapping(value = "/login")
	public String login(@ModelAttribute("user") User user1, String userId, String password, Model model,
			HttpSession session) {
		User user = pmsService.login(userId, password);
		if (user != null) {
			session.setAttribute("user", user);
			if (user.getRoleType() == 0) {
				return "manager/userMg";
			} else
				return "user/user_login";
		} else {
			model.addAttribute("errorMessage", "登录失败，请重新登录");
			return "user/user_login";
		}
	}

	@RequestMapping(value = "/change")
	public String change(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		User user = (User) (session.getAttribute("user"));
		String password = "";
		String phone = "";
		try {
			password = request.getParameter("password");
			phone = request.getParameter("phone");
			if (!StringUtils.isEmpty(password)) {
				password = new String(password.getBytes("iso-8859-1"), "utf-8");
			}
			if (!StringUtils.isEmpty(phone)) {
				phone = new String(phone.getBytes("iso-8859-1"), "utf-8");
			}
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String userId = user.getUserId();
		pmsService.change(password, phone, userId);
		model.addAttribute("errorMessage", "修改成功，请重新登录");
		user = null;
		session.setAttribute("user", user);
		return "user/user_login";
	}

	@RequestMapping(value = { "/", "/index" })
	public String fist(Model model) {
		return "user/user_login";
	}

	@RequestMapping(value = "/signout")
	public String logout(HttpSession session, Model model) {
		User user = null;
		session.setAttribute("user", user);
		return "user/user_login";
	}

	@RequestMapping(value = "/user/user-list")
	public void selectUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String key = request.getParameter("key");
		String pageNoStr = request.getParameter("pageNo");
		String rowMaxStr = request.getParameter("rowMax");
		String roleTypeStr = request.getParameter("roleType");
		int pageNo = Integer.valueOf(pageNoStr);
		int rowMax = Integer.valueOf(rowMaxStr);
		int roleType = Integer.valueOf(roleTypeStr);
		User user = new User();
		user.setUserName(key);
		user.setRoleType(roleType);
		PageVO<User> page = pmsService.listUser(user, pageNo, rowMax);
		response.reset();
		response.setContentType("text/plain;charset=UTF-8");
		response.getWriter().print(JSON.toJSONString(page));
		response.flushBuffer();
	}

	@RequestMapping(value = "/user/addUser")
	public void addUser(@ModelAttribute("user") User user) {
		if (user.getSexId() == 0) {
			user.setSex("男");
		} else {
			user.setSex("女");
		}
		user.setRoleType(user.getTypeId());
		pmsService.addUser(user);

		System.out.println("add user :" + user.getUserId());
		user = null;
	}

	@RequestMapping(value = "/user/updateUser")
	public void updateUser(@ModelAttribute("user") User user) {
		// User user = new User();
		if (user.getSexId() == 0) {
			user.setSex("男");
		} else {
			user.setSex("女");
		}
		user.setRoleType(user.getTypeId());
		pmsService.modifyUser(user);
	}

	@RequestMapping(value = "/user/deleteUser")
	public void deleteUser(@RequestBody User user, HttpServletResponse response) {
		String userId = user.getUserId();
		pmsService.removeUserById(userId);
		System.out.println("delete user :" + userId);

	}

	@RequestMapping(value = "/user/loadEditUser")
	@ResponseBody
	public Object loadEditUser(@RequestParam(value = "name", required = false) String name) {
		User user = new User();
		user = pmsService.findUserById(name);
		System.out.println("load user :" + user.getUserName());
		return user;
	}

	@RequestMapping(value = { "/userMg" })
	public String userMg(@ModelAttribute("user") User user) {
		return "manager/userMg";
	}

	@RequestMapping(value = "/info")
	public String about() {
		return "user/about";
	}

}
