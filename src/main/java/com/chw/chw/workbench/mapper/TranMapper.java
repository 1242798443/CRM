package com.chw.chw.workbench.mapper;

import com.chw.chw.workbench.domain.FunnelVO;
import com.chw.chw.workbench.domain.Tran;
import com.chw.chw.workbench.domain.TranVo;

import java.util.List;
import java.util.Map;

public interface TranMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_tran
     *
     * @mbggenerated Sat Apr 17 15:39:32 CST 2021
     */
    int deleteByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_tran
     *
     * @mbggenerated Sat Apr 17 15:39:32 CST 2021
     */
    int insert(Tran record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_tran
     *
     * @mbggenerated Sat Apr 17 15:39:32 CST 2021
     */
    int insertSelective(Tran record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_tran
     *
     * @mbggenerated Sat Apr 17 15:39:32 CST 2021
     */
    Tran selectByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_tran
     *
     * @mbggenerated Sat Apr 17 15:39:32 CST 2021
     */
    int updateByPrimaryKeySelective(Tran record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_tran
     *
     * @mbggenerated Sat Apr 17 15:39:32 CST 2021
     */
    int updateByPrimaryKey(Tran record);

    void insertTran(Tran tran);

    Tran selectTranForDetailById(String id);

    List<FunnelVO> selectCountOfTranGroupByStage();

    List<TranVo> selectTranForPageByCondition(Map<String, Object> map);

    long selectCountofTran(Map<String, Object> map);
}