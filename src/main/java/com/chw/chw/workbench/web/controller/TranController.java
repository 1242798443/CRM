package com.chw.chw.workbench.web.controller;

import com.chw.chw.commons.contants.Contants;
import com.chw.chw.commons.domain.ReturnObject;
import com.chw.chw.commons.utils.DateUtils;
import com.chw.chw.commons.utils.UUIDUtils;
import com.chw.chw.settings.domain.DicValue;
import com.chw.chw.settings.domain.User;
import com.chw.chw.settings.service.DicValueService;
import com.chw.chw.settings.service.UserService;
import com.chw.chw.workbench.domain.*;
import com.chw.chw.workbench.service.CustomerService;
import com.chw.chw.workbench.service.TranHistoryService;
import com.chw.chw.workbench.service.TranRemarkService;
import com.chw.chw.workbench.service.TranService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
public class TranController {
    @Autowired
    private UserService userService;

    @Autowired
    private DicValueService dicValueService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private TranService tranService;

    @Autowired
    private TranRemarkService tranRemarkService;

    @Autowired
    private TranHistoryService tranHistoryService;

    @RequestMapping("workbench/transaction/queryTranForPageByCondition.do")
    public @ResponseBody Object queryContactsForPageByCondition(int pageNo, int pageSize, String transctionOwner, String transctionname, String transctioncustomerName, String transctionstate, String transctionkinds, String transctionSource, String transctionconstacts){
        Map<String,Object> map= new HashMap<>();
        map.put("beginNo",(pageNo-1)*pageSize);
        map.put("pageSize",pageSize);
        map.put("transctionOwner",transctionOwner);
        map.put("transctionname",transctionname);
        map.put("transctioncustomerName",transctioncustomerName);
        map.put("transctionstate",transctionstate);
        map.put("transctionkinds",transctionkinds);
        map.put("transctionSource",transctionSource);
        map.put("transctionconstacts",transctionconstacts);

        //????????????????????????
        List<TranVo> tranList=tranService.queryTranForPageByCondition(map);
        //?????????????????????
        long totalRows=tranService.queryCountOfTranByCondition(map);
        Map<String,Object> retMap=new HashMap<>();
        retMap.put("tranList",tranList);
        retMap.put("totalRows", totalRows);

        return retMap;
    }

    @RequestMapping("/workbench/transaction/index.do")
    public String index(Model model){
        //??????service??????????????????????????????
        List<DicValue> stageList=dicValueService.queryDicValueByTypeCode("stage");
        List<DicValue> transactionTypeList=dicValueService.queryDicValueByTypeCode("transactionType");
        List<DicValue> sourceList=dicValueService.queryDicValueByTypeCode("source");
        //??????????????????request???
        model.addAttribute("stageList",stageList);
        model.addAttribute("transactionTypeList",transactionTypeList);
        model.addAttribute("sourceList",sourceList);
        //????????????
        return "workbench/transaction/index";
    }


    @RequestMapping("/workbench/transaction/createTran.do")
    public String createTran(Model model){
        //??????service??????????????????????????????
        List<User> userList=userService.getUser();
        List<DicValue> stageList=dicValueService.queryDicValueByTypeCode("stage");
        List<DicValue> transactionTypeList=dicValueService.queryDicValueByTypeCode("transactionType");
        List<DicValue> sourceList=dicValueService.queryDicValueByTypeCode("source");
        //??????????????????request???
        model.addAttribute("userList",userList);
        model.addAttribute("stageList",stageList);
        model.addAttribute("transactionTypeList",transactionTypeList);
        model.addAttribute("sourceList",sourceList);
        //????????????
        return "workbench/transaction/save";
    }

    @RequestMapping("/workbench/transaction/getPossibilityByStageValue.do")
    public @ResponseBody Object getPossibilityByStageValue(String stageValue){
        //??????properties????????????????????????   ResourceBundle??????????????????
        ResourceBundle bundle=ResourceBundle.getBundle("possibility");
        String possibility=bundle.getString(stageValue);
        return possibility;
    }
    @RequestMapping("/workbench/transaction/queryCustomerByName.do")
    public @ResponseBody Object queryCustomerByName(String customerName){
        //??????service????????????????????????
        List<Customer> customerList=customerService.queryCustomerByName(customerName);
        return customerList;
    }
    @RequestMapping("/workbench/transaction/saveCreateTran.do")
    public @ResponseBody Object saveCreateTran(Tran tran, String customerName, HttpSession session){
        User user=(User)session.getAttribute(Contants.SESSION_USER);
        //????????????
        tran.setId(UUIDUtils.getUUID());
        tran.setCreateBy(user.getId());
        tran.setCreateTime(DateUtils.formatDateTime(new Date()));

        Map<String,Object> map=new HashMap<>();
        map.put("tran",tran);
        map.put("customerName",customerName);
        map.put("sessionUser",user);

        ReturnObject returnObject=new ReturnObject();
        try {
            //??????service????????????????????????
            tranService.saveCreateTran(map);
            returnObject.setMessage("??????");
            returnObject.setCode(Contants.RETURN_OBJECT_CODE_SUCCESS);
        }catch (Exception e){
            e.printStackTrace();
            returnObject.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("????????????");
        }

        return returnObject;
    }
    @RequestMapping("/workbench/transaction/typeahead.do")
    public @ResponseBody Object typeahead(String customerName){
        //??????service??????????????????customerName??????????????????????????????List<String>
        /*List<String> list=new ArrayList<>();
        list.add("????????????");
        list.add("????????????");
        list.add("???XXXXX");
        list.add("???YYYYY");*/

        List<Customer> customerList=new ArrayList<>();
        Customer customer=new Customer();
        customer.setId("1001");
        customer.setName("????????????");
        customerList.add(customer);
        customer=new Customer();
        customer.setId("1002");
        customer.setName("????????????");
        customerList.add(customer);
        customer=new Customer();
        customer.setId("1003");
        customer.setName("??????");
        customerList.add(customer);
        customer=new Customer();
        customer.setId("1004");
        customer.setName("??????");
        customerList.add(customer);

        return customerList;// [{id:'1001',name:'????????????',...},{id:'1002',name:'????????????',....},.......]
    }

    @RequestMapping("/workbench/transaction/detailTransacttion.do")
    public String detailTran(String id,Model model){
        //??????service????????????????????????
        Tran tran=tranService.queryTranForDetailById(id);
        List<TranRemark> remarkList=tranRemarkService.queryTranRemarkForDetailByTranId(id);
        List<TranHistory> tranHistoryList=tranHistoryService.queryTranHistoryForDetailByTranId(id);

        //??????possibility?????????????????????????????????????????????????????????
        ResourceBundle bundle=ResourceBundle.getBundle("possibility");
        String possibility=bundle.getString(tran.getStage());
        tran.setPossibility(possibility);

        //??????????????????request???
        model.addAttribute("tran",tran);
        model.addAttribute("remarkList",remarkList);
        model.addAttribute("tranHistoryList",tranHistoryList);
        //model.addAttribute("possibility",possibility);

        //?????????????????????????????????????????????????????????????????????
        List<DicValue> stageList=dicValueService.queryDicValueByTypeCode("stage");
        model.addAttribute("stageList",stageList);
        //model.addAttribute("stageListLength",stageList.size());

        //????????????????????????????????????????????????orderNo
        TranHistory tranHistory=null;
        for(int i=tranHistoryList.size()-1;i>=0;i--){
            tranHistory=tranHistoryList.get(i);
            if(Integer.parseInt(tranHistory.getOrderNo())<Integer.parseInt(stageList.get(stageList.size()-3).getOrderNo())){
                //tranHistory???orderNo?????????????????????
                model.addAttribute("theOrderNo",tranHistory.getOrderNo());
                break;
            }
        }

        //????????????
        return "workbench/transaction/detail";
    }
}
