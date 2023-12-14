<template>
  <div>
    <van-nav-bar title="车辆添加" left-text="返回" left-arrow @click-left="onClickLeft" />
    <van-cell-group>
      <van-field v-model="form.licenseNumber" required clearable label="车牌号" right-icon="question-o" placeholder="请输入车牌号"
        @click-right-icon="$toast('question')" />

      <van-field v-model="form.brand" label="车辆品牌" placeholder="请输入车辆品牌" required />
      <van-field v-model="form.color" label="颜色" placeholder="请输入颜色" required />
      <van-field v-model="form.parking" label="停车位号" placeholder="请输入停车位号" required />
      <div class="upload-container">
        <span>车辆照片</span>
        <van-uploader v-if="!fileList.length" name="uploader" :after-read="onRead">
          <van-icon name="photograph" />
        </van-uploader>
        <div v-else class="img-box">
          <img class="upload-img" :src="fileList[0].content" @click="previewImg" alt="" srcset="">
          <van-icon class="del" color="#ff4444" size="15px" name="clear" @click="delPhoto()" />
        </div>
      </div>
      <van-button type="info" @click="handleSubmit">提交</van-button>
    </van-cell-group>
  </div>
</template>

<script>
import { ImagePreview, Toast } from 'vant';
import { createVehicle } from '@/api/vehicle'
export default {
  data() {
    return {
      form: {
        licenseNumber: "",
        brand: "",
        color: "",
        parking: ""
      },
      fileList: []
    }
  },
  methods: {
    onClickLeft() {
      this.$router.push({
        name: 'vehicle'
      })
    },
    async handleSubmit() {
      try {
        const { data } = await createVehicle({
          ...this.form,
          userId: this.$store.state.user.id
        });
        Toast(data.msg);
        this.$router.push({
          name: 'vehicle'
        })
      } catch (error) {
        Toast(error);
      }
    },
    onRead(file) {
      console.log();
      this.fileList.push(file);
    },
    delPhoto() {
      this.fileList.splice(0, 1);
    },
    previewImg() {
      ImagePreview({
        images: [
          'https://img.yzcdn.cn/1.jpg',
          'https://img.yzcdn.cn/2.jpg'
        ],
        startPosition: 1,
        onClose() {
          // do something
        }
      });
    }
  }
}
</script>

<style lang="scss" scoped>
.upload-container {
  width: 100%;
  box-sizing: border-box;
  color: #323233;
  font-size: 14px;
  line-height: 24px;
  background-color: #fff;
  padding: 10px 15px;
  .van-uploader {
    margin: 0 0 0 30px;
  }
  .img-box {
    position: relative;
    .del {
      position: absolute;
      top: 0;
      right: 26%;
    }
    .upload-img {
      margin: 0 0 0 90px;
      width: 50%;
      height: 50%;
  }
  }
  
}
</style>