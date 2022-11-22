package com.kh.forworks.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.util.PatternMatchUtils;

@Component
public class LoginCheckFilter implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		String rootPath = httpRequest.getServletContext().getContextPath();
		//체크할 주소들
		String[] blackList = {rootPath+"/att/*", rootPath+"/off/*"};
//		System.out.println(rootPath);
		
		String requestURI = httpRequest.getRequestURI();
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		
//		System.out.println(requestURI);
		
		if(isLoginCheckPath(blackList, requestURI)) {
			//로그인 했는 지 확인하고 했으면 보내주기 아니면 다시 로그인 화면으로
			HttpSession session = httpRequest.getSession();
			
			if(session == null || session.getAttribute("loginMember") == null) {
				httpResponse.sendRedirect(rootPath + "/login");
				return;
			} else {
				chain.doFilter(request, response);
			}			
		} else {
			//로그인 여부 확인없이 그냥 보내주기
			chain.doFilter(request, response);
		}
		
	}
	
	/*
	 * private boolean isLoginCheckPath(String requestURI) { return
	 * !PatternMatchUtils.simpleMatch(whiteList, requestURI); }
	 */

	private boolean isLoginCheckPath(String[] blackList, String requestURI) { 
		return PatternMatchUtils.simpleMatch(blackList, requestURI);
	}
}
