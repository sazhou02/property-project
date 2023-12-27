<template>
  <div class="feedback-wrap">
    <Input v-model="name" style="margin-bottom: 20px;width: 30%" search enter-button placeholder="请输入姓名"
        @on-search="loadData" />
    <Table class="table" border :columns="columns" :data="dataSource"></Table>
    <Spin size="large" fix v-if="spinShow"></Spin>
  </div>
</template>

<script>
  import { getFeedback, updateFeedbackStatus } from "@/api/user";
  export default {
    data() {
      return {
        name: "",
        spinShow: false,
        dataSource: [],
        columns: [
          {
            title: "反馈编号",
            key: "id",
            align: "center",
            width: 100,
          },
          {
            title: "姓名",
            key: "name",
            align: "center"
          },
          {
            title: "电话",
            key: "phone",
            align: "center",
          },
          {
            title: "状态",
            key: "status",
            align: "center",
            render: (h, params) => {
              return h("span", params.row.status === 0 ? "未处理" : "已处理");
            }
          },
          {
            title: "反馈内容",
            key: "message",
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
                    size: 'small',
                    disabled: params.row.status === 1
                  },
                  style: {
                    marginRight: '5px'
                  },
                  on: {
                    click: async () => {
                      await updateFeedbackStatus({
                        id: params.row.id
                      });
                      this.$Message.success('已处理!');
                      this.loadData();
                    }
                  }
                }, params.row.status === 0 ? '处理' : '已处理')
              ]);
            }
          }
        ]
      }
    },
    created() {
      this.loadData();
    },
    methods: {
      async loadData() {
        this.spinShow = true;
        const res = await getFeedback({
          name: this.name
        });
        this.dataSource = res.data.data;
        this.spinShow = false;
      }
    }
  }
</script>

<style lang="scss" scoped>
.feedback-wrap {
  position: relative;
  width: 95%;
  margin: 30px auto;
}

</style>