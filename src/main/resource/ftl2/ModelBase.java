package com.jelly.picdict.model;

import java.util.HashSet;
import java.util.Set;

public class ModelBase {
    /* for select by page*/
    private int offset;

    private int length;

    private Set<String> likeSqlColumnSet = new HashSet<>();

    public Set<String> getLikeSqlColumnSet() {
        return likeSqlColumnSet;
    }

    public ModelBase setLikeSqlColumnSet(Set<String> likeSqlColumnSet) {
        this.likeSqlColumnSet = likeSqlColumnSet;
        return this;
    }

    public int getOffset() {
        return offset;
    }

    public ModelBase setOffset(int offset) {
        this.offset = offset;
        return this;
    }

    public int getLength() {
        return length;
    }

    public ModelBase setLength(int length) {
        this.length = length;
        return this;
    }
}
