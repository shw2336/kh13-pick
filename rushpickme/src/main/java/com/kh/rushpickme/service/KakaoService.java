package com.kh.rushpickme.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;




@Service
public class KakaoService {
	
	
	
//	 public String getAccessTokenFromKakao(String client_id, String code) throws IOException {
//	        //------kakao POST 요청------
//	        String reqURL = "https://kauth.kakao.com/oauth/token";
//	        URL url = new URL(reqURL);
//	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//	        conn.setRequestMethod("POST");
//	        
//	        conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
//	        
//	        conn.setDoOutput(true);
//	        conn.setDoInput(true);
//	        //파라미터 추가
//	        //?grant_type=authorization_code&client_id="+client_id+"&code=" + code
//	        StringBuffer buffer = new StringBuffer();
//	        System.out.println("client_id = " + client_id);
//	        System.out.println("code = " + code);
//	        
//	        buffer.append("grant_type=authorization_code&client_id="+client_id+"&code=" + code+"&redirect_uri=http://localhost:8080/auth/kakao/callback");
//	        PrintWriter pw = new PrintWriter(new OutputStreamWriter(conn.getOutputStream(), "UTF-8"));
//	        pw.write(buffer.toString());
//	        pw.flush();
//
//	        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
//
//	        String line = "";
//	        String result = "";
//
//	        while ((line = br.readLine()) != null) {
//	            result += line;
//	        }
//
//	        ObjectMapper objectMapper = new ObjectMapper();
//	        Map<String, Object> jsonMap = objectMapper.readValue(result, new TypeReference<Map<String, Object>>() {
//	        });
//
//	        log.info("Response Body : " + result);
//
//	        String accessToken = (String) jsonMap.get("access_token");
//	        String refreshToken = (String) jsonMap.get("refresh_token");
//	        String scope = (String) jsonMap.get("scope");
//
//
//	        log.info("Access Token : " + accessToken);
//	        log.info("Refresh Token : " + refreshToken);
//	        log.info("Scope : " + scope);
//
//
//	        return accessToken;
//	    }
	
	
	public String getAccessTokenFromKakao(String client_id, String code) throws IOException, URISyntaxException {
		String reqURL = "https://auth.kakao.com/oauth/token";
		URI uri = new URI(reqURL);
		
		RestTemplate template = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
//		headers.add("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
		
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("grant_type", "authorization_code");
		body.add("client_id", client_id);
//		body.add("redirect_uri", "http://localhost:8080/auth/kakao/callback");
		body.add("code", code);
		
		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body, headers);
		
		Map response = template.postForObject(uri, entity, Map.class);
		System.out.println(response);
		
		return null;
	}

	    public HashMap<String, Object> getUserInfo(String access_Token) throws IOException {
	        // 클라이언트 요청 정보
	        HashMap<String, Object> userInfo = new HashMap<String, Object>();


	        //------kakao GET 요청------
	        String reqURL = "https://kapi.kakao.com/v2/user/me";
	        URL url = new URL(reqURL);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Authorization", "Bearer " + access_Token);

	        int responseCode = conn.getResponseCode();
	        System.out.println("responseCode : " + responseCode);

	        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

	        String line = "";
	        String result = "";

	        while ((line = br.readLine()) != null) {
	            result += line;
	        }

	  

	        // jackson objectmapper 객체 생성
	        ObjectMapper objectMapper = new ObjectMapper();
	        // JSON String -> Map
	        Map<String, Object> jsonMap = objectMapper.readValue(result, new TypeReference<Map<String, Object>>() {});

	        //System.out.println(jsonMap);

	        //사용자 정보 추출
	        Map<String, Object> properties = (Map<String, Object>) jsonMap.get("properties");
	        Map<String, Object> kakao_account = (Map<String, Object>) jsonMap.get("kakao_account");


	        Long id = (Long) jsonMap.get("id");
	        String nickname = properties.get("nickname").toString();
	        String profileImage = properties.get("profile_image").toString();
	        String email = kakao_account.get("email").toString();

	        //userInfo에 넣기
	        userInfo.put("id", id);
	        userInfo.put("nickname", nickname);
	        userInfo.put("profileImage", profileImage);
	        userInfo.put("email", email);
	        
	      

	        return userInfo;
	    }

}
