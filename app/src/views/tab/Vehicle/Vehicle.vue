<template>
	<div>
		<van-nav-bar title="车辆信息" right-text="添加" @click-right="onClickRight" />
		<div>
			<no-data />
			<van-card tag="标签" price="车牌号" desc="车辆颜色" title="停车位" :thumb="imageURL">
				<div slot="footer">
					<van-button size="mini">查看详情</van-button>
					<van-button size="mini">删除</van-button>
				</div>
			</van-card>
		</div>

	</div>
</template>

<script>
import noData from '@/components/noData';
export default {
	name: "Vehicle",
	components: {
		noData
	},
	data() {
		return {
			imageURL: "../../../assets/noPhoto",
			msg: "车辆信息录入"
		}
	},
	methods: {
		onClickRight() {
			this.$router.push({
				path: "/addVehicle"
			})
		}
	}
}
</script>

<style lang="scss" scoped></style>