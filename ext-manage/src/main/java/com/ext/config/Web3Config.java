package com.ext.config;

import one.yiran.dashboard.common.constants.Global;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.web3j.protocol.Web3j;
import org.web3j.protocol.http.HttpService;

@Configuration
public class Web3Config {

    @Bean(name = "polygonWeb3j")
    public Web3j web3j(){
        String url = Global.getConfig("dashboard.web3j.polygonRpc");
        Web3j web3j = Web3j.build(new HttpService(url, true));
        return web3j;
    }
}
