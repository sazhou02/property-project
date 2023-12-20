<template>
	<div>
		<div class="wrap">
			<Button type="primary" @click="handleAdd">新增</Button>
			<Table class="table" border :columns="columns" :data="userList"></Table>
			<Spin size="large" fix v-if="spinShow"></Spin>
		</div>
		<div style="margin: 10px;overflow: hidden">
			<div style="float: right;">
				<Page :page-size="10" :total="total" :current="page + 1" @on-change="changePage"></Page>
			</div>
		</div>
		<Modal v-model="modalVisible" :title="modalTitle" @on-cancel="cancel">
			<Form ref="formValidate" :model="formModel" :rules="ruleValidate" :label-width="80">
				<FormItem label="用户名" prop="name">
					<Input v-model="formModel.name" clearable placeholder="请输入用户名"></Input>
				</FormItem>
				<FormItem v-if="modalTitle === '新增'" label="密码" prop="password">
					<Input v-model="formModel.password" type="password" clearable placeholder="请输入密码"></Input>
				</FormItem>
				<FormItem v-if="modalTitle === '新增'" label="确认密码" prop="confirm_password">
					<Input v-model="formModel.confirm_password" type="password" clearable placeholder="请再次输入密码"></Input>
				</FormItem>
				<FormItem label="姓名" prop="nick_name">
					<Input v-model="formModel.nick_name" clearable placeholder="请输入姓名"></Input>
				</FormItem>
				<FormItem label="电话" prop="tel">
					<Input v-model="formModel.tel" type="tel" clearable placeholder="请输入电话"></Input>
				</FormItem>
				<FormItem label="性别" prop="sex">
					<RadioGroup v-model="formModel.sex">
						<Radio label="0">男</Radio>
						<Radio label="1">女</Radio>
					</RadioGroup>
				</FormItem>
				<FormItem label="房间" prop="room_id">
					<Select v-model="formModel.room_id">
						<Option v-for="item in roomoptions" :value="item.value" :key="item.value">{{ item.label }}</Option>
					</Select>
				</FormItem>
			</Form>
			<template slot="footer">
				<Button @click="cancel">取消</Button>
				<Button type="primary" @click="ok">确定</Button>
			</template>
		</Modal>
	</div>
</template>
<script>
import {
	getHomeUsers,
	userToOwner
} from '@/api/homeUsers'
import {
	getRoom
} from '@/api/room';
import {
	updateUser
} from '@/api/homeUsers';
import {
	Component,
	Prop,
	Vue,
} from 'vue-property-decorator';
function deepClone(obj, hash = new WeakMap()) {
	if (obj === null) return null; // 如果是null或者undefined我就不进行拷贝操作
	if (obj instanceof Date) return new Date(obj);
	if (obj instanceof RegExp) return new RegExp(obj);
	// 可能是对象或者普通的值，如果是函数的话就不需要深拷贝
	if (typeof obj !== "object") return obj;
	// 是对象的话就要进行深拷贝
	if (hash.has(obj)) return hash.get(obj); // 查哈希表，防止循环拷贝
	let cloneObj = new obj.constructor();
	// 找到的是所属类原型上的constructor,而原型上的 constructor指向的是当前类本身
	hash.set(obj, cloneObj);
	for (let key in obj) {
		if (obj.hasOwnProperty(key)) {
			// 实现一个递归拷贝
			cloneObj[key] = deepClone(obj[key], hash);
		}
	}
	return cloneObj;
}

function filterObjectByTemplate(sourceObject, templateObject) {
  const templateKeys = Object.keys(templateObject);
  return Object.keys(sourceObject).reduce((filteredObject, key) => {
    if (templateKeys.includes(key)) {
      filteredObject[key] = sourceObject[key];
    }
    return filteredObject;
  }, {});
}
@Component()
export default class HomeUser extends Vue {
	columns = [{
		title: '用户名',
		key: 'name'
	},
	{
		title: '姓名',
		key: 'nick_name',
		render: (h, params) => {
			return params.row.nick_name ? h('div', params.row.nick_name) : h('div', [h('span', {
				style: {
					color: '#c5c8ce'
				}
			}, '暂无')])
		}
	},
	{
		title: '性别',
		key: 'sex'
	},
	{
		title: '房间',
		key: 'room'
	},
	{
		title: '联系电话',
		key: 'tel',
		render: (h, params) => {
			return params.row.tel ? h('div', params.row.tel) : h('div', [h('span', {
				style: {
					color: '#c5c8ce'
				}
			}, '暂无')])
		}
	},
	{
		title: '操作',
		key: 'action',
		width: 200,
		align: 'center',
		render: (h, params) => {
			return h('div', [
				h('Button', {
					props: {
						type: 'info'
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
					},
					on: {
						click: () => {
							this.toOwner(params.row)
						}
					}
				}, '设为业主')
			]);
		}
	}
	];
	formModel = {
		name: "",
		password: "",
		confirm_password: "",
		nick_name: "",
		tel: "",
		sex: "",
		room_id: "",
		role: 1
	}
	ruleValidate = {
		name: [
			{ required: true, message: '用户名不可为空', trigger: 'blur' }
		],
		password: [
			{ required: true, message: '密码不可为空', trigger: 'blur' }
		],
		confirm_password: [
			{ required: true, message: '请确认密码', trigger: 'blur' }
		],
		nickName: [
			{ required: true, message: '姓名不可为空', trigger: 'change' }
		],
		tel: [
			{ required: true, message: '电话不可为空', trigger: 'blur' }],
		sex: [
			{ required: true, trigger: 'change' }
		],
		roomId: [
			{ transform: (value) => String(value), required: true, message: '请选择房间', trigger: 'change' }
		]
	}
	page = 0;
	total = 2;
	userList = [];
	spinShow = true;
	modalVisible = false;
	modalTitle = "新增";
	roomoptions = [];
	handleEdit(row) {
		const formModel = deepClone(row);
		formModel.sex = formModel.sex === "男" ? "0" : "1";
		this.formModel = filterObjectByTemplate(formModel, this.formModel);
		this.formModel.id = formModel.id;
		this.modalTitle = "编辑";
		this.modalVisible = true;
	};
	async getRoomOptions() {
		const res = await getRoom();
		this.roomoptions = res.data.data.map(item => {
			return {
				value: item.id,
				label: `${item.building}号楼${item.room_num}室`
			}
		});
	};
	toOwner(row) {
		this.$Modal.confirm({
			title: '提示',
			render: (h) => {
				return h('p', `确定要将${row.nick_name ? row.nick_name : row.name}设${row.room}为业主？`)
			},
			onOk: () => {
				userToOwner(row).then(res => {
					this.$Message.success(res.data.msg);
					this.page = 0
					this.fetchData()
				})

			}
		})
	}
	changePage(page) {
		this.page = page - 1
		this.spinShow = true
		this.fetchData()
	}
	async fetchData() {
		const res = await getHomeUsers({
			role: 1,
			page: this.page,
		})
		this.userList = res.data.data.map(item => {
			return {
				...item,
				sex: item.sex == 0 ? '男' : '女',
				room: `${item.building}号楼${item.room_num}室`
			}
		})
		this.total = res.data.total
		setTimeout(() => {
			this.spinShow = false
		}, 100)

	};
	handleAdd() {
		this.modalTitle = "新增";
		this.modalVisible = true;
	}
	ok() {
		this.$refs.formValidate.validate(async (valid) => {
			if (valid) {
				const { password, confirm_password } = this.formModel;
				console.log(this.formModel);
				if (password !== confirm_password) {
					this.$Message.error('两次密码不一致');
					return;
				}
				const res = await updateUser(this.formModel);
				if (res.data.code === 20000) {
					this.$Message.success('提交成功!');
					this.cancel();
					this.fetchData();
				} else {
					this.$Message.error('提交失败');
				}

			} else {
				this.$Message.error('Fail!');
			}
		})
	}
	cancel() {
		this.modalVisible = false;
		this.$refs.formValidate.resetFields();
	}
	created() {
		this.fetchData();
		this.getRoomOptions();
	}
}
</script>
<style lang="scss" scoped>
.wrap {
	position: relative;
	width: 95%;
	margin: 30px auto;

	.table {
		margin-top: 20px;
		;
	}
}
</style>