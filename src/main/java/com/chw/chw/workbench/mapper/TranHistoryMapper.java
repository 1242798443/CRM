package com.chw.chw.workbench.mapper;

import com.chw.chw.workbench.domain.TranHistory;

import java.util.List;

public interface TranHistoryMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_tran_history
     *
     * @mbggenerated Sat Apr 17 15:39:32 CST 2021
     */
    int deleteByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_tran_history
     *
     * @mbggenerated Sat Apr 17 15:39:32 CST 2021
     */
    int insert(TranHistory record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_tran_history
     *
     * @mbggenerated Sat Apr 17 15:39:32 CST 2021
     */
    int insertSelective(TranHistory record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_tran_history
     *
     * @mbggenerated Sat Apr 17 15:39:32 CST 2021
     */
    TranHistory selectByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_tran_history
     *
     * @mbggenerated Sat Apr 17 15:39:32 CST 2021
     */
    int updateByPrimaryKeySelective(TranHistory record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_tran_history
     *
     * @mbggenerated Sat Apr 17 15:39:32 CST 2021
     */
    int updateByPrimaryKey(TranHistory record);

    void insertTranHistory(TranHistory tranHistory);

    List<TranHistory> selectTranHistoryForDetailByTranId(String tranId);
}