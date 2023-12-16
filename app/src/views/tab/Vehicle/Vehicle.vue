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
					:desc="item.brand" :title="'停车位：' + item.parking"
					:thumb="item.photos && JSON.parse(item.photos).length != 0 ? JSON.parse(item.photos)[0] : defaultImg">
					<div slot="footer">
						<van-button size="mini">查看详情</van-button>
						<van-button size="mini">删除</van-button>
					</div>
				</van-card>
			</template>
		</div>

	</div>
</template>

<script>
import noData from '@/components/noData';
import { getVehicle } from '@/api/vehicle';
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
		async fetchData() {
			const vm = this
			var res = await getVehicle({
				userId: this.$store.state.user.id,
				licenseNumber: vm.licenseNumber
			})
			this.vehicleList = res.data.data;
			console.log(this.vehicleList)
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