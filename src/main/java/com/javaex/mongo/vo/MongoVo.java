package com.javaex.mongo.vo;

import org.springframework.data.mongodb.core.mapping.Document;

//MonoTestVo는 정보를 spring_ex 컬렉션에 집어 넣겠다.
@Document(collection="jblog")
public class MongoVo {

	private String hostIp;
	private String addrIP;
	private String localPort;
	private String localName;
	private String protocol;
	private String scheme;
	private String contextPath;
	private String uri;
	
	public MongoVo(String hostIp, String addrIP, String localPort, String localName, String protocol, String scheme,
			String contextPath, String uri) {
		super();
		this.hostIp = hostIp;
		this.addrIP = addrIP;
		this.localPort = localPort;
		this.localName = localName;
		this.protocol = protocol;
		this.scheme = scheme;
		this.contextPath = contextPath;
		this.uri = uri;
	}
	
	
	public String getHostIp() {
		return hostIp;
	}
	public void setHostIp(String hostIp) {
		this.hostIp = hostIp;
	}
	public String getAddrIP() {
		return addrIP;
	}
	public void setAddrIP(String addrIP) {
		this.addrIP = addrIP;
	}
	public String getLocalPort() {
		return localPort;
	}
	public void setLocalPort(String localPort) {
		this.localPort = localPort;
	}
	public String getLocalName() {
		return localName;
	}
	public void setLocalName(String localName) {
		this.localName = localName;
	}
	public String getProtocol() {
		return protocol;
	}
	public void setProtocol(String protocol) {
		this.protocol = protocol;
	}
	public String getScheme() {
		return scheme;
	}
	public void setScheme(String scheme) {
		this.scheme = scheme;
	}
	public String getContextPath() {
		return contextPath;
	}
	public void setContextPath(String contextPath) {
		this.contextPath = contextPath;
	}
	public String getUri() {
		return uri;
	}
	public void setUri(String uri) {
		this.uri = uri;
	}
	@Override
	public String toString() {
		return "MongoVo [hostIp=" + hostIp + ", addrIP=" + addrIP + ", localPort=" + localPort + ", localName="
				+ localName + ", protocol=" + protocol + ", scheme=" + scheme + ", contextPath=" + contextPath
				+ ", uri=" + uri + "]";
	}

	
}
