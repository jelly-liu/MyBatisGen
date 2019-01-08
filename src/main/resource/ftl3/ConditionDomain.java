package ${modelPackage};

import org.apache.commons.lang3.StringUtils;

import java.util.HashSet;
import java.util.Set;

/**
 * do not try to add or delete any property in this class
 */
public class ConditionDomain {
    /* for select by page*/
    private Integer offset;
    private Integer length;

    /* for sql like */
    private Set<String> likeSqlColumnSet;
    /* for sql order by */
    private Set<SortCondition> sortConditionSet;

    public Integer getOffset() {
        return offset;
    }

    public ConditionDomain setOffset(Integer offset) {
        this.offset = offset;
        return this;
    }

    public Integer getLength() {
        return length;
    }

    public ConditionDomain setLength(Integer length) {
        this.length = length;
        return this;
    }

    public Set<String> getLikeSqlColumnSet() {
        return likeSqlColumnSet;
    }

    public ConditionDomain setLikeSqlColumnSet(Set<String> likeSqlColumnSet) {
        this.likeSqlColumnSet = likeSqlColumnSet;
        return this;
    }

    public Set<SortCondition> getSortConditionSet() {
        return sortConditionSet;
    }

    public ConditionDomain setSortConditionSet(Set<SortCondition> sortConditionSet) {
        this.sortConditionSet = sortConditionSet;
        return this;
    }

    public ConditionDomain likeAdd(String name){
        if(StringUtils.isEmpty(name)){
            return null;
        }

        if(likeSqlColumnSet == null)likeSqlColumnSet = new HashSet<>();
        likeSqlColumnSet.add(name);
        return this;
    }

    public ConditionDomain orderByAdd(SortCondition sortCondition){
        if(sortCondition == null){
            return null;
        }

        if(sortCondition.colName == null){
            return null;
        }

        if(sortCondition.sort == null){
            return null;
        }

        if(sortConditionSet == null) sortConditionSet = new HashSet<>();
        sortConditionSet.add(sortCondition);
        return this;
    }

    /* 排序方式 */
    public enum Sort{
        ASC, DESC
    }

    public static final class SortCondition{
        private String colName;
        private Sort sort;

        public SortCondition(String colName, Sort sort) {
            this.colName = colName;
            this.sort = sort;
        }

        @Override
        public int hashCode() {
            return colName.hashCode();
        }

        @Override
        public boolean equals(Object obj) {
            SortCondition sortCondition = (SortCondition) obj;
            return StringUtils.equals(colName, sortCondition.colName);
        }
    }
}
