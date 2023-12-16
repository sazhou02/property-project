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
        <van-uploader :after-read="onRead" multiple :max-size="307200" @oversize="oversize">
          <van-icon name="photograph" />
        </van-uploader>
        <template>
          <div class="img-box" v-for="(item, index) in fileList" :key="index">
            <img class="upload-img" :src="item" @click="previewImg(index)">
            <van-icon class="del" color="#ff4444" size="15px" name="clear" @click="delPhoto()" />
          </div>
        </template>
      </div>
      <van-button type="info" size="large" @click="handleSubmit">提交</van-button>
    </van-cell-group>
  </div>
</template>

<script>
import { ImagePreview, Toast } from 'vant';
import { createVehicle, uploadVehicleImage } from '@/api/vehicle'
export default {
  data() {
    return {
      form: {
        licenseNumber: "",
        brand: "",
        color: "",
        parking: ""
      },
      fileList: [],
      photoPath: []
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
          photos: JSON.stringify(this.photoPath),
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
    async onRead(file) {
      if (file.content) {
        this.fileList.push(file.content)
      } else {
        this.fileList = [...this.fileList, ...(file.map(item => item.content))]
      }
      this.photoPath = (await uploadVehicleImage(this.fileList)).data.data.path;
    },
    delPhoto() {
      this.fileList.splice(0, 1);
    },
    previewImg(index) {
      ImagePreview({
        images: this.fileList,
        startPosition: index,
        showIndex: true,
        onClose() {
          // do something
        }
      });
    },
    oversize() {
      Toast.fail('照片大小超出限制！最大可上传300KB照片')
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