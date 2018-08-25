package com.shuyan.nginx.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

/**
 * @author will
 * 测试负载均衡，将这个代码的jar运行在不同端口上做负载均衡，查看返回结果
 * 测试内容
 *   1. 负载均衡是否生效
 *      生效
 *   2. http块或server块中 分别使用或不使用 proxy_set_header 的结果
 *      不使用
 *   3. 这几个 header 作用
 */
@RestController
public class TestController {
    @Value("${server.port}")
    private String port;

    @GetMapping("/test")
    public Map<String,Object> test(HttpServletRequest request){
        Map<String,Object> map = new HashMap<>(2048);
        map.put("port",port);
        map.put("remote_addr",request.getRemoteAddr());
        Enumeration<String> headerNames = request.getHeaderNames();
        while (headerNames.hasMoreElements()){
            String header = headerNames.nextElement();
            map.put(header,request.getHeader(header));
        }
        return map;
    }
}
