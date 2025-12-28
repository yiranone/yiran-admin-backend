package com.ext.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import one.yiran.db.common.domain.TimedBasedEntity;

import javax.persistence.*;

@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@Entity
@Table(name = "biz_notice")
public class Notice extends TimedBasedEntity {

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Long channelId;

    /**
     * 公告标题
     */
    @Column
    private String title;

    /**
     * 公告描述
     */
    @Column
    private String description;

    /**
     * 公告内容
     */
    @Column(length = 500)
    private String content;

    /**
     * 公告链接
     */
    @Column
    private String link;

    /**
     * 状态(1:公布;0:不发布)
     *
     */
    @Column
    private Integer status;

    /**
     * 是否置顶（1:是;0:否）
     */
    @Column
    private Integer isTop;

    /**
     * 是否轮播（1:是;0:否）
     */
    @Column
    private Integer isPlay;
}
