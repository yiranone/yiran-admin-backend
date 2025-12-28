package com.ext.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import one.yiran.dashboard.common.annotation.Excel;
import one.yiran.db.common.domain.TimedBasedEntity;

import javax.persistence.*;
import java.util.Date;

@EqualsAndHashCode(callSuper = false)
@Table(name = "biz_member", indexes = {
        @Index(name = "idx_la_chid", columnList = "loginAddress,channelId", unique = true),
        @Index(name = "idx_loginAddress", columnList = "loginAddress")
})
@Entity
@Data
public class Member extends TimedBasedEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Excel(name = "会员ID", cellType = Excel.ColumnType.NUMERIC)
    private Long id;

    @Column(nullable = false)
    private Long channelId;

    @Column(length = 6)
    private String memberCode;

    @Column(length = 64)
    private String loginAddress;

    @Column(length = 8, nullable = false)
    @Excel(name = "帐号状态", readConverterExp = "1=正常,2=停用")
    private String status;

    @Column(nullable = false)
    @Excel(name = "注册时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss", type = Excel.Type.EXPORT)
    private Date registerTime;

    @Column(length = 64)
    @Excel(name = "最后登陆IP", type = Excel.Type.EXPORT)
    private String loginIp;

    @Column
    @Excel(name = "最后登陆时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss", type = Excel.Type.EXPORT)
    private Date loginTime;
}
