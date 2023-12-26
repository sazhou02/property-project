<template>
    <div class="login-wrap">
        <p class="header">登录/注册</p>
        <img class="wrap-bg" src="../assets/banner-icon.png" alt="" srcset="">
        <van-tabs v-model="active" :line-width="20" color="#5064eb" title-active-color="#5064eb" animated>
            <van-tab title="登录">
                <van-cell-group class="form">
                    <van-field v-model="userName" required clearable left-icon="manager" placeholder="请输入用户名" />
                    <van-field v-model="password" type="password" left-icon="lock" placeholder="请输入密码" required />
                </van-cell-group>
                <van-button
                    style="margin-top: 30px; width: 90%; left: 50%; transform: translate(-50%, 0); background-color: #5064eb; color: #fff; border-radius: 20px;"
                    @click="login">登陆</van-button>
                <span class="register">
                    <router-link style="text-decoration: underline #fff" :to="{ path: '/register' }">点此注册</router-link>
                </span>
            </van-tab>
            <van-tab title="注册">
                <van-cell-group class="register-form">
                    <van-field v-model="form.name" required clearable label="用户名" placeholder="请输入用户名"
                        :error-message="/^[a-zA-Z][a-zA-Z0-9_]{4,15}$/.test(form.name) ? '' : '字母开头，允许5-16字节，允许字母数字下划线'" />
                    <van-field v-model="form.nick_name" clearable label="姓名" placeholder="请输入姓名" />
                    <van-field v-model="form.password" type="password" label="密码" placeholder="请输入密码" required
                        :error-message="/^[a-zA-Z]\w{5,17}$/.test(form.password) ? '' : '以字母开头，长度在6~18之间，只能包含字母、数字和下划线'" />
                    <van-field v-model="form.tel" label="手机号" placeholder="请输入手机号" required
                        :error-message="/^1[34578]\d{9}$/.test(form.tel) ? '' : '请输入正确格式手机号码'" />
                    <van-cell title="所属房间" is-link :value="selectRoom || '请选择'" @click="showRoom = true" />
                    <van-cell title="性别">
                        <van-radio-group v-model="form.sex">
                            <van-radio name="0">男</van-radio>
                            <van-radio name="1">女</van-radio>
                        </van-radio-group>
                    </van-cell>

                </van-cell-group>
                <van-popup v-model="showRoom" position="bottom" :overlay="true">
                    <van-picker show-toolbar :columns="roomList" @cancel="onCancel" @confirm="onConfirm"
                        @change="onChange" />
                </van-popup>
                <van-button class="reg-btn"
                style="margin-top: 30px; width: 90%; left: 50%; transform: translate(-50%, 0); background-color: #5064eb; color: #fff; border-radius: 20px;"
                @click="register">注册</van-button>
            </van-tab>
        </van-tabs>
    </div>
</template>

<script>
import md5 from 'js-md5'
import { Toast } from 'vant';
import {
    getRoom
} from '@/api/room'
import {
    createUser
} from '@/api/user'
import {
    Component,
    Prop,
    Vue,
} from 'vue-property-decorator';

@Component
export default class Login extends Vue {
    userName = 't1';
    password = 'aaaaaa';
    active = 0;
    login() {
        const vm = this;
        this.$store.dispatch('LOGIN', {
            name: vm.userName,
            password: md5(vm.password)
        }).then(res => {
            if (res.data.code == '20000') {
                Toast.success('登录成功')
                vm.$router.push({
                    path: '/main/room'
                })
            } else {
                Toast.fail(res.data.msg)
            }
        });
    };
    form = {
        name: '',
        password: '',
        nick_name: '',
        sex: '',
        room_id: '',
        tel: ''
    };
    roomList = []; // 选择器的数据
    room = []; // 处理后的数据
    resroom = []; // 数据原型
    selectRoom = '';
    showRoom = false;
    onCancel() {
        this.showRoom = false
    };
    onConfirm(value) {
        this.form.room_id = this.resroom.find(item => item.room_num == value[1]).id
        this.selectRoom = value[0] + '号楼' + this.resroom.find(item => item.room_num == value[1]).room_num + '室'
        this.showRoom = false
    };
    register() {
        const form = { ...this.form }
        if (/^[a-zA-Z][a-zA-Z0-9_]{4,15}$/.test(form.name) && /^[a-zA-Z]\w{5,17}$/.test(form.password) && /^1[34578]\d{9}$/.test(form.tel) && form.room_id && form.sex && form.nick_name) {
            form.password = md5(form.password)
            createUser(form).then(res => {
                if (res.data.code == '20000') {
                    Toast.success('注册成功')
                } else {
                    Toast.fail(res.data.msg)
                }
            })
        } else {
            Toast.fail('请正确完善注册信息')
        }
    };
    onChange(picker, values) {
        picker.setColumnValues(1, this.room[values[0]]);
    };
    created() {
        const vm = this
        getRoom().then(res => {
            var room = res.data.data
            vm.resroom = room
            room.forEach(item => {
                if (vm.room[item.building]) {
                    vm.room[item.building].push(item.room_num)
                } else {
                    vm.room[item.building] = [item.room_num]
                }
            })
            vm.roomList = [{
                values: Object.keys(vm.room)
            }, {
                values: vm.room['1']
            }]
        })
    }
}
</script>
<style lang="scss">

.login-wrap {
    padding-top: 50px;
    box-sizing: border-box;
    height: 100%;
    background-color: #5064eb;
    background-size: cover;
    position: relative;

    .header {
        position: absolute;
        left: 0;
        top: 0;
        width: 100%;
        color: #fff;
        text-align: center;
        font-size: 18px;
    }

    .wrap-bg {
        display: block;
        width: 60%;
        position: absolute;
        right: 0;
        top: 8%;
        z-index: 9;
    }

    .van-tabs--line {
        padding-top: 60px;
    }

    .van-tabs {
        position: absolute;
        z-index: 1;
        top: 25%;
        width: 100%;
        height: 75%;
    }

    .van-tab {
        flex: 0.2;
    }

    .van-tabs__wrap {
        width: 95%;
        height: 60px !important;
        margin: 0 auto;
        border-radius: 8px 8px 0 0;
    }

    .van-tabs__wrap .van-tab {
        font-size: 16px;
        line-height: 60px;
    }

    .van-tabs__wrap .van-tab--active {
        font-size: 20px;
    }

    .van-tabs__content {
        height: 100%;
        background-color: #fff;
    }

    p {
        text-align: center;
        color: #fff;
        font-size: 20px;
        margin-bottom: 30px;
    }

    .form {
        height: 150px;
        display: flex;
        flex-direction: column;
        justify-content: space-evenly;
    }

    .form {
        width: 90%;
        left: 50%;
        transform: translate(-50%, 0);

        .van-cell {
            background-color: rgba(51, 136, 255, 0.2);
            border-radius: 30px;
        }
    }

    .register-form {
        width: 90%;
        margin: 0 auto;
    }

    .register {
        position: absolute;
        right: 5%;
        margin-top: 90px;

        a {
            color: #fff;
        }
    }
}

.wrap /deep/ .van-cell-group {
    background-color: rgba(255, 255, 255, 0.8)
}

.form /deep/ .van-cell {
    background-color: rgba(255, 255, 255, 0)
}

.wrap /deep/ .van-button--default {
    background: #3388ff;
    border: 1px solid #3388ff;
    color: #fff
}
</style>
