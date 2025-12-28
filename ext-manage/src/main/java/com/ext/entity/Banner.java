package com.ext.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import one.yiran.db.common.domain.TimedBasedEntity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@Entity
@Table(name = "biz_banner")
public class Banner extends TimedBasedEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Long channelId;

    @Column
    private String bannerName;

    @Column
    private String bannerLink;

    @Column
    private Integer bannerType;

    @Column
    private String imageUrl;

    @Column
    private Integer position;

    @Column
    private String content;

    @Column
    private Integer status;

    @Column
    private Integer sort;
}
