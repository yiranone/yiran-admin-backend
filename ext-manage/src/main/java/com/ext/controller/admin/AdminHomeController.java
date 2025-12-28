package com.ext.controller.admin;

import lombok.extern.slf4j.Slf4j;
import one.yiran.dashboard.common.annotation.AjaxWrapper;
import one.yiran.dashboard.common.model.UserSession;
import one.yiran.dashboard.entity.QSysAnalysisItem;
import one.yiran.dashboard.entity.SysAnalysisItem;
import one.yiran.dashboard.security.SessionContextHelper;
import one.yiran.dashboard.service.SysAnalysisItemService;
import one.yiran.db.common.util.PredicateBuilder;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@AjaxWrapper
@Controller
@RequestMapping("/biz/home")
public class AdminHomeController {

    @Autowired
    private SysAnalysisItemService analysisItemService;

    @RequestMapping("/member/count")
    public Map<String, Object> memberCount() {
        UserSession loginUser = SessionContextHelper.getLoginUser();
        Long channelId = loginUser.getChannelId();

        QSysAnalysisItem qAnalysisItem = QSysAnalysisItem.sysAnalysisItem;
        Map<String, Object> result = new HashMap<>();

        LocalDate nowDate = LocalDate.now();
        LocalDate yesterdayDate = nowDate.plusDays(-1);
        LocalDate lastweekDate = yesterdayDate.plusDays(-7);

        List<SysAnalysisItem> dbDatas = analysisItemService.selectList(PredicateBuilder.builder().addEqualIfNotBlank(qAnalysisItem.channelId, channelId)
                .addExpression(qAnalysisItem.type.in(SysAnalysisItem.TYPE_MEMBER))
                .addExpression(qAnalysisItem.belongDate.in(nowDate, yesterdayDate, lastweekDate)).toList());

        long totalRegisterCount = getMapValue(dbDatas, nowDate, SysAnalysisItem.TYPE_MEMBER, "TotalRegisterCount");
        long todayRegisterCount = getMapValue(dbDatas, nowDate, SysAnalysisItem.TYPE_MEMBER, "RegisterCount");
        long yesterdayRegisterCount = getMapValue(dbDatas, yesterdayDate, SysAnalysisItem.TYPE_MEMBER, "RegisterCount");

        result.put("totalRegisterCount", totalRegisterCount);
        result.put("todayRegisterCount", todayRegisterCount);
        result.put("yesterdayRegisterCount", yesterdayRegisterCount);

        LocalDate twoWeeksAgoDate = nowDate.plusDays(-14);
        dbDatas = analysisItemService.selectList(PredicateBuilder.builder().addEqualIfNotBlank(qAnalysisItem.channelId, channelId)
                .addExpression(qAnalysisItem.type.in(SysAnalysisItem.TYPE_MEMBER))
                .addExpression(qAnalysisItem.keyName.in("LoginCount", "LoginCount", "RegisterCount", "TwoWeeksLoginCount"))
                .addExpression(qAnalysisItem.belongDate.between(twoWeeksAgoDate, nowDate)).toList());

        //注册人数
        long twoWeeksRegisterCount = 0;
        List<Long> registerCounts = new ArrayList<>();
        List<String> registerCountDates = new ArrayList<>();
        for (LocalDate s = twoWeeksAgoDate; s.compareTo(nowDate) <= 0; s = s.plusDays(1)) {
            long v = getMapValue(dbDatas, s, SysAnalysisItem.TYPE_MEMBER, "RegisterCount");
            twoWeeksRegisterCount += v;
            registerCounts.add(v);
            registerCountDates.add(s.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
        }
        result.put("registerCountY", registerCounts);
        result.put("registerCountX", registerCountDates);
        result.put("averageRegisterCount", twoWeeksRegisterCount / registerCounts.size());
        result.put("twoWeeksRegisterCount", twoWeeksRegisterCount);

        //登陆人数
        long totalLoginCount = 0;
        List<Long> loginCounts = new ArrayList<>();
        List<String> loginCountDates = new ArrayList<>();
        for (LocalDate s = twoWeeksAgoDate; s.compareTo(nowDate) <= 0; s = s.plusDays(1)) {
            long v = getMapValue(dbDatas, s, SysAnalysisItem.TYPE_MEMBER, "LoginCount");
            totalLoginCount += v;
            loginCounts.add(v);
            loginCountDates.add(s.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
        }
        result.put("loginCountY", loginCounts);
        result.put("loginCountX", loginCountDates);
        result.put("averageLoginCount", totalLoginCount / loginCounts.size());
        //近两周登录人数
        long twoWeeksLoginCount = getMapValue(dbDatas, nowDate, SysAnalysisItem.TYPE_MEMBER, "TwoWeeksLoginCount");
        result.put("twoWeeksLoginCount", twoWeeksLoginCount);
        return result;
    }

    private BigDecimal getMapBigDecimalValue(List<SysAnalysisItem> lists, LocalDate belongDate, String type, String subType, String keyName) {
        for (SysAnalysisItem ai : lists) {
            boolean belongDateEq = false;
            if (belongDate == null && ai.getBelongDate() == null ||
                    ai.getBelongDate() != null && belongDate != null && ai.getBelongDate().isEqual(belongDate)) {
                belongDateEq = true;
            }
            if (subType == null)
                subType = "";
            String compareSubType = ai.getSubType() == null ? "" : ai.getSubType();
            if (belongDateEq && StringUtils.equals(type, ai.getType()) &&
                    StringUtils.equals(subType, compareSubType) &&
                    StringUtils.equals(ai.getKeyName(), keyName)) {
                return new BigDecimal(ai.getValue());
            }
        }
        return BigDecimal.ZERO;
    }

    private long getMapValue(List<SysAnalysisItem> lists, LocalDate belongDate, String type, String keyName) {
        return getMapBigDecimalValue(lists, belongDate, type, null, keyName).longValue();
    }
}
