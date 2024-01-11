<template>
  <div>
    <div class="wrap">
      <Input v-model="payName" style="margin-bottom: 20px;width: 50%" search enter-button placeholder="请输入缴费人姓名"
        @on-search="loadData" />
      <Button type="primary" @click="handleAdd">新增缴费</Button>
      <Table class="table" border :columns="columns" :data="dataSource"></Table>
      <Spin size="large" fix v-if="spinShow"></Spin>
    </div>

    <Modal v-model="modalVisible" title="新增缴费" @on-visible-change="visibleChange">

      <Form ref="formValidate" :model="formValidate" :rules="ruleValidate" :label-width="100">
        <FormItem label="缴费类型" prop="payType">
          <Select v-model="formValidate.payType" placeholder="请选择缴费类型">
            <Option value="dianfei">电费</Option>
            <Option value="shuifei">水费</Option>
            <Option value="ranqifei">燃气费</Option>
            <Option value="nuanqifei">暖气费</Option>
            <Option value="wuyefei">物业费</Option>
            <Option value="tingchefei">停车费</Option>
          </Select>
        </FormItem>
        <FormItem label="缴费人姓名" prop="userId">
          <Select v-model="formValidate.userId" :label-in-value="true" placeholder="请选择缴费人" @on-change="nameChange">
            <Option v-for="item in userOptions" :value="item.value" :key="item.value">{{ item.label }}</Option>
          </Select>
        </FormItem>
        <FormItem label="金额" prop="amount">
          <Input v-model="formValidate.amount" placeholder="请输入金额"></Input>
        </FormItem>
        <FormItem label="缴费方式" prop="payMethod">
          <Select v-model="formValidate.payMethod" placeholder="请选择缴费方式">
            <Option value="zhifubao">支付宝</Option>
            <Option value="weixin">微信</Option>
            <Option value="yinhangka">银行卡</Option>
          </Select>
        </FormItem>
        <FormItem label="备注" prop="notes">
          <Input v-model="formValidate.notes" type="textarea" :autosize="{ minRows: 2, maxRows: 5 }"
            placeholder="请输入备注"></Input>
        </FormItem>
      </Form>
      <div slot="footer">
        <Button @click="handleReset('formValidate')" style="margin-left: 8px">Reset</Button>
        <Button type="primary" @click="handleSubmit('formValidate')">Submit</Button>
      </div>
    </Modal>
  </div>
</template>

<script>
import { getPayment, createPayment, updatePayment, deletePayment } from "@/api/pay";
import { getHomeUsers } from "@/api/homeUsers";
import { deepClone, keysToCamelCase } from "../../utils/utils";
export default {
  name: "Vehicle",
  data() {
    return {
      modalAction: "add",
      userOptions: [],
      modalVisible: false,
      spinShow: false,
      payName: "",
      dataSource: [],
      columns: [
        {
          title: "编号",
          key: "id",
          align: "center",
          width: 100,
        },
        {
          title: "缴费类型",
          key: "pay_type",
          align: "center",
          render: (h, params) => {
            let text = "";
            switch (params.row.pay_type) {
              case "shuifei":
                text = "水费";
                break;
              case "dianfei":
                text = "电费";
                break;
              case "ranqifei":
                text = "燃气费";
                break;
              case "nuanqifei":
                text = "暖气费";
                break;
              case "wuyefei":
                text = "物业费";
                break;
              case "tingchefei":
                text = "停车费";
                break;
            }
            return h("div", text);
          },
        },
        {
          title: "缴费人姓名",
          key: "nick_name",
          align: "center",
        },
        {
          title: "缴费金额",
          key: "amount",
          align: "center",
        },
        {
          title: "付款方式",
          key: "pay_method",
          align: "center",
          render: (h, params) => {
            let text = "";
            switch (params.row.pay_method) {
              case "weixin":
                text = "微信支付";
                break;
              case "zhifubao":
                text = "支付宝支付";
                break;
              case "yinhangka":
                text = "银行卡";
                break;
            }
            return h("div", text);
          },
        },
        {
          title: "是否缴费",
          key: "pay_status",
          align: "center",
          render: (h, params) => {
            let text = "";
            switch (params.row.pay_status) {
              case 1:
                text = "已缴费";
                break;
              case 0:
                text = "未缴费";
                break;
            }
            return h("div", text);
          },
        },
        {
          title: "备注",
          key: "notes",
          align: "center",
        },
        {
          title: '操作',
          key: 'action',
          width: 200,
          align: 'center',
          fixed: 'right',
          render: (h, params) => {
            return h('div', [
              h('Button', {
                props: {
                  type: 'primary',
                  size: 'small'
                },
                style: {
                  marginRight: '5px'
                },
                on: {
                  click: () => {
                    this.handleEdit(params.row)
                  }
                }
              }, '编辑'),
              h('Button', {
                props: {
                  type: 'error',
                  size: 'small'
                },
                style: {
                  marginRight: '5px'
                },
                on: {
                  click: () => {
                    this.handleDel(params.row)
                  }
                }
              }, '删除')
            ]);
          }
        }
      ],
      formValidate: {
        payType: '',
        userId: void 0,
        amount: void 0,
        payMethod: '',
        notes: "",
        payName: ""
      },
      ruleValidate: {
        payType: [
          { required: true, message: '请选择缴费类型', trigger: 'change' }
        ],
        userId: [
          { required: true, message: '请选择缴费人' }
        ],
        amount: [
          { required: true, message: '请输入金额', trigger: 'blur' }
        ],
        payMethod: [
          { required: true, message: '请选择缴费方式', trigger: 'change' }
        ],
        notes: [
          { required: true, message: '请输入备注', trigger: 'blur' }
        ]
      }
    }
  },
  created() {
    this.loadData();
    this.getUserList();
  },
  methods: {
    async getUserList() {
      const { data } = await getHomeUsers();
      this.userOptions = data.data.map(item => {
        return {
          label: item.nick_name,
          value: item.id
        }
      });
    },
    async loadData() {
      this.spinShow = true;
      const res = await getPayment({
        payName: this.payName
      });
      this.dataSource = res.data.data;
      this.spinShow = false;
    },
    handleAdd() {
      this.modalAction = 'add';
      this.modalVisible = true;
    },
    handleSubmit(name) {
      this.$refs[name].validate(async (valid) => {
        if (valid) {
          try {
            let data;
            // 根据 modalAction 类型调用相应的 API 函数
            if (this.modalAction === 'add') {
              ({ data } = await createPayment(this.formValidate));
            } else {
              ({ data } = await updatePayment(this.formValidate));
            }

            if (data.code === 20000) {
              this.$Message.success(`${this.modalAction === 'add' ? '创建' : '更新'}成功!`);
              this.modalVisible = false;
              this.loadData();
            } else {
              this.$Message.error(`操作失败: ${data.msg}`);
            }
          } catch (error) {
            // 捕获并处理 try 块中的任何异常
            this.$Message.error(`请求过程中发生错误: ${error}`);
          }
        } else {
          this.$Message.error('Fail!');
        }
      })
    },
    handleReset(name) {
      this.$refs[name].resetFields();
    },
    nameChange(val) {
      this.formValidate.payName = val.label;
    },
    visibleChange(val) {
      if (!val) {
        this.handleReset('formValidate');
      }
    },
    handleEdit(row) {
      this.modalAction = 'edit';
      const editObj = deepClone(row);
      this.formValidate = keysToCamelCase(editObj);
      console.log(this.formValidate);
      this.modalVisible = true;
    },
    handleDel(row) {
      this.$Modal.confirm({
        title: '提示',
        content: '<p>确认删除该条数据吗？</p>',
        onOk: async () => {
          try {
            const { data } = await deletePayment({ id: row.id }
            );
            if (data.code === 20000) {
              this.$Message.success('删除成功!');
              this.loadData();
            } else {
              this.$Message.error(`操作失败: ${data.msg}`);
            }
          } catch (error) {
            // 捕获并处理 try 块中的任何异常
            this.$Message.error(`请求过程中发生错误: ${error}`);
          }
        }
      });
    }
  }
}
</script>

<style lang="scss" scoped>
.wrap {
  position: relative;
  width: 95%;
  margin: 30px auto;
}

.carousel {
  width: 488px;
  text-align: center;

  img {
    max-width: 100%;
  }
}
</style>