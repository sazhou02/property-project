<template>
	<div>
		<van-nav-bar title="车辆信息" right-text="添加" @click-right="onClickRight" />
		<van-search v-model="licenseNumber" placeholder="请输入车牌号" show-action @search="fetchData">
			<div slot="action" @click="fetchData">搜索</div>
		</van-search>
		<div>
			<no-data v-if="vehicleList.length == 0" />
			<template v-else>
				<van-card v-for="(item, index) in vehicleList" :key="index" currency="" :price="item.license_number"
					:desc="'颜色：' + item.color" :title="'停车位：' + item.parking"
					:thumb="item.photos && JSON.parse(item.photos).length != 0 ? JSON.parse(item.photos)[0] : defaultImg">
					<div slot="footer">
						<van-button size="mini" @click="handleDel(item.id)">删除</van-button>
					</div>
					<div slot="tags">
						<span>品牌：{{ item.brand }}</span>
					</div>
				</van-card>
			</template>
		</div>

	</div>
</template>

<script>
import noData from '@/components/noData';
import { getVehicle, deleteVehicle } from '@/api/vehicle';
export default {
	name: "Vehicle",
	components: {
		noData
	},
	data() {
		return {
			imageURL: "../../../assets/noPhoto",
			msg: "车辆信息录入",
			licenseNumber: "",
			vehicleList: [],
			defaultImg: require('@/assets/noPhoto.png')
		}
	},
	created() {
		this.fetchData();
	},
	methods: {
		handleDel(id) {
			const _this = this;
			this.$dialog.confirm({
				title: '删除提示',
				message: '确定删除该车辆信息吗？'
			}).then(
				async () => {
					const res = await deleteVehicle({
						id
					})
					if (res.data.code == 20000) {
						this.$toast('删除成功');
						_this.fetchData();
					}
				}
			).catch(() => {
				this.$toast('取消删除');
			})
		},
		async fetchData() {
			const vm = this
			var res = await getVehicle({
				userId: this.$store.state.user.id,
				licenseNumber: vm.licenseNumber
			})
			this.vehicleList = res.data.data;
		},
		onClickRight() {
			this.$router.push({
				path: "/addVehicle"
			})
		}
	}
}
</script>

<style lang="scss" scoped></style>