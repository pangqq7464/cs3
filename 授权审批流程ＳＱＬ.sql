--授权规则查询，可根据申请单id查询申请单，取得function_code查询授权规则
select * from bs_apprule_dict where function_code ='1319'

--查询审批人，可根据申请单id查询申请单，取得appbusi_code查询规则审批人
select * from bs_appruleitem_dict where rule_id ='1000049375'

--查询申请单
select * from  bs_apply_rc where function_code  = '1023'   order by apply_time desc
select * from bs_apply_rc where apply_id = '1001265010'

select * from bs_apply_rc where function_code = '3707'
--查询审批流程
select * from bs_approveflow_rc where apply_id = '1001264896'
--查询审批意见
select * from bs_approve_rc where apply_id = '1001264896'


--申请单深审批
--1、将申请单状态变更为3
update bs_apply_rc set process_status = '4' where apply_id = '1001264896'
--2、将审批流程状态变更为3
update bs_approveflow_rc set process_status = '4' where apply_id = '1001264896'
--3、添入审批意见,login_no 为审批人工号，通过规则id查询审批人即可查到
update bs_approve_rc set login_no = '' ,approve_flag = '1'  where apply_id = ''



select LOGIN_NO, PASSWORD, PARTY_ID, LAST_LOGIN_TIME, EFF_TIME, EXP_TIME, NICK_NAME, LOGIN_FAIL_NUM, STATUS, RELOGIN_FLAG, LOGIN_TYPE, LOGIN_FLAG, OP_TIME, PASS_TIME, EXPIRE_TIME, MODIFY_PASSWD_INTERVAL, TRY_TIMES, ALLOW_END, ALLOW_BEGIN, REDIS_FLAG, SENDPWD_FLAG, MAC_ADDRESS, CREATE_LOGIN, REMARK, LOGIN_ID, MAX_ERRNUM, LOGIN_STATUS, PROVINCE_ID from EP_LOGIN where 1=1 AND PROVINCE_ID='220000' and login_no = 'haT100' 


select * from bs_approveloginlimit_dict  where  function_code = '1319'
delete from  bs_approveloginlimit_dict  where  function_code = '1319'



--申请前查询是否需要授权申请
--先根据条件来查询审批规则是否存在
select a.RULE_ID,
       a.GROUP_ID,Ａ
       a.FUNCTION_CODE,
       to_char(a.CREATE_TIME, 'YYYY-MM-DD HH24:MI:SS') CREATE_TIME,
       a.LAST_MODIFY_TIME,
       a.CREATE_LOGIN,
       b.LEVEL_ID,
       b.LOGIN_NO,
       b.LOGIN_NO || '(' || c.NICK_NAME || ')' LOGIN_NAME,
       a.APPBUSI_CODE
  from BS_APPRULE_DICT a,
       (select rule_id, level_id, login_no, op_time
          from (select rule_id, level_id, login_no, op_time
                  from bs_appruleitem_dict
                union all
                select b.rule_id,
                       (select to_char(max(c.level_id) + 1)
                          from bs_appruleitem_dict c
                         where c.rule_id = b.rule_id) level_id,
                       a.approve_login,
                       b.create_time
                  from bs_approveloginlimit_dict a, bs_apprule_dict b
                 where a.function_code = b.function_code                                  
                   and a.appbusi_code = b.appbusi_code)) b,
       EP_LOGIN c
 where a.RULE_ID = b.RULE_ID
   and b.LOGIN_NO = c.LOGIN_NO
   
   AND A.FUNCTION_CODE = '3707'
   AND A.GROUP_ID ='4'
   AND A.APPBUSI_CODE = 'APP_3707_001'  
   
   
 --再根据条件查询申请单是否存在
   SELECT A.APPLY_ID,
          A.APPLY_LOGIN,
          A.FUNCTION_CODE,
          A.APPBUSI_CODE,
          A.PROCESS_STATUS,
          (select NICK_NAME from ep_login c where A.APPLY_LOGIN = C.LOGIN_NO) LOGIN_NAME,
          A.PHONE_NO,
          to_char(A.APPLY_TIME, 'YYYY-MM-DD HH24:MI:SS') APPLY_TIME,
          A.OP_NOTE,
          B.APPLY_TITLE,
          B.APPLY_CONTENT
     FROM BS_APPLY_RC A, BS_APPLYCONTENT_INFO B
    WHERE A.APPLY_ID = B.APPLY_ID
      AND A.APPBUSI_CODE = ?
      AND A.PHONE_NO = ?
      AND A.FUNCTION_CODE = ?
      AND A.APPLY_LOGIN = ?
    ORDER BY A.APPLY_TIME DESC
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
