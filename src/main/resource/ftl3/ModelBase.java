package com.krc.lottery.model.framework;

import java.util.LinkedHashSet;
import java.util.Set;

/**
 * do not try to add or delete any property in this class
 */
public class ModelBase {
    /* for select by page*/
    private Integer offset;
    private Integer length;

    /* for sql like */
    private Set<String> likeSqlColumnSet;

    public Integer getOffset() {
        return offset;
    }

    public com.krc.lottery.model.framework.ModelBase setOffset(Integer offset) {
        this.offset = offset;
        return this;
    }

    public Integer getLength() {
        return length;
    }

    public com.krc.lottery.model.framework.ModelBase setLength(Integer length) {
        this.length = length;
        return this;
    }

    public Set<String> getLikeSqlColumnSet() {
        return likeSqlColumnSet;
    }

    public com.krc.lottery.model.framework.ModelBase setLikeSqlColumnSet(Set<String> likeSqlColumnSet) {
        this.likeSqlColumnSet = likeSqlColumnSet;
        return this;
    }

    public com.krc.lottery.model.framework.ModelBase likeAdd(String name){
        if(likeSqlColumnSet == null)likeSqlColumnSet = new LinkedHashSet<>();
        likeSqlColumnSet.add(name);
        return this;
    }
}
