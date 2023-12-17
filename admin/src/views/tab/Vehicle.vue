<template>
  <div>
    <div class="wrap">
      <Input v-model="licenseNumber" style="margin-bottom: 20px;width: 50%" search enter-button placeholder="请输入车牌号"
        @on-search="loadData" />
      <Table class="table" border :columns="columns" :data="dataSource"></Table>
      <Spin size="large" fix v-if="spinShow"></Spin>
    </div>

    <Modal v-model="showCarouselModel" title="车辆照片" :footer-hide="true">
      <Carousel style="width: 488px" :height="450">
        <CarouselItem class="carousel" v-for="(item, index) in photos" :key="index">
          <img :src="item" alt="">
        </CarouselItem>
      </Carousel>

    </Modal>
  </div>
</template>

<script>
import { getVehicle } from "@/api/vehicle";
export default {
  name: "Vehicle",
  data() {
    return {
      photos: [],
      showCarouselModel: false,
      spinShow: false,
      licenseNumber: "",
      dataSource: [],
      columns: [
        {
          title: "车辆编号",
          key: "id",
          align: "center",
          width: 100,
        },
        {
          title: "停车场编号",
          key: "parking",
          align: "center"
        },
        {
          title: "车牌号",
          key: "license_number",
          align: "center",
        },
        {
          title: "车辆品牌",
          key: "brand",
          align: "center",
        },
        {
          title: "车辆颜色",
          key: "color",
          align: "center",
        },
        {
          title: "车主姓名",
          key: "nick_name",
          align: "center",
        },
        {
          title: "车主电话",
          key: "tel",
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
                    this.showCarousel(params.row)
                  }
                }
              }, '图片')
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
      const res = await getVehicle({
        licenseNumber: this.licenseNumber
      });
      this.dataSource = res.data.data;
      this.spinShow = false;
    },

    showCarousel(row) {
      if (row.photos) {
        this.photos = JSON.parse(row.photos)
        this.showCarouselModel = true
      } else {
        this.photos = []
        this.$Message.warning('此报修未上传照片！');
      }

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