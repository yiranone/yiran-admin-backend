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
@Table(name = "biz_question")
public class Question extends TimedBasedEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Long channelId;

    @Column
    private String title;

    @Column(columnDefinition = "text")
    private String content;

    @Column
    private Integer sortNo;
}
