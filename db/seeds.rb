# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: 'trungpro151224@gmail.com', password: 'admin123', username: 'admin', admin: true, phone: "0978860750", location: "So 50, Nguyen Trai, Quan 5", fullname: "Tran Huu Trung")
User.create(email: 'phan.quang.lam@persol.co.jp', password: 'admin234', username: 'ﾌｧﾝ ｸｱﾝ ﾗﾑ', admin: false, phone: "023434555", location: "So 50, Nguyen Kiem, Quan Tan Binh", fullname: "Phan Dinh Tung")
User.create(email: 'masashi.sanematsu@persol.co.jp', password: 'admin334', username: '實松 将', admin: false, phone: "0123234345", location: "So 50, Nguyen Huu Tho, Quan 7", fullname: "Tran Trung Tam")
User.create(email: 'h.kano@persol.co.jp', password: 'admin434', username: '鹿野 宏美', admin: false, phone: "0123456788", location: "So 10, Nguyen Trai, Quan 8", fullname: "Tran Minh Phuc")
User.create(email: 'dai.omori@persol.co.jp', password: 'admin543', username: '大森 大', admin: false, phone: "0124578964", location: "So 20, Pham Huu Lau, Quan 9", fullname: "Tran Trung Tin")
User.create(email: 'mio.kakai@persol.co.jp', password: 'admin634', username: '抱井 美緒', admin: false, phone: "0124578976", location: "So 30, Duong 3-2, Quan 10", fullname: "Tran Ngoc Phu")
# a = User.new(email: 'mio2.kakaix@persol.co.jp', password: 'admin6342', username: '抱井1美緒2', fullname: "Tran Ngoc Phu") test

Color.create(name: 'NAVY', code: '#001f3f;')
Color.create(name: 'BLUE', code: '#0074D9;')
Color.create(name: 'AQUA', code: '#7FDBFF;')
Color.create(name: 'TEAL', code: '#39CCCC;')
Color.create(name: 'OLIVE', code: '#3D9970;')
Color.create(name: 'GREEN', code: '#2ECC40;')
Color.create(name: 'LIME', code: '#01FF70;')
Color.create(name: 'YELLOW', code: '#FFDC00;')
Color.create(name: 'ORANGE', code: '#FF851B;')
Color.create(name: 'RED', code: '#FF4136;')
Color.create(name: 'MAROON', code: '#85144b;')
Color.create(name: 'FUCHSIA', code: '#F012BE;')
Color.create(name: 'PURPLE', code: '#B10DC9;')
Color.create(name: 'BLACK', code: '#111111;')
Color.create(name: 'GRAY', code: '#AAAAAA;')
Color.create(name: 'SILVER', code: '#DDDDDD;')

Post.create(title: "post1", discription: "description1")
Post.create(title: "post2", discription: "description2")
Post.create(title: "post3", discription: "description3")
Post.create(title: "post4", discription: "description4")
Post.create(title: "post5", discription: "description5")
Post.create(title: "post6", discription: "description6")
Post.create(title: "post7", discription: "description7")
Post.create(title: "post8", discription: "description8")
Post.create(title: "post9", discription: "description9")
Post.create(title: "post10", discription: "description10")