# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: 'trungpro151224@gmail.com', password: 'admin123', username: 'admin', admin: true)
User.create(email: 'phan.quang.lam@persol.co.jp', password: 'admin234', username: 'ﾌｧﾝ ｸｱﾝ ﾗﾑ', admin: false)
User.create(email: 'masashi.sanematsu@persol.co.jp', password: 'admin334', username: '實松 将', admin: false)
User.create(email: 'h.kano@persol.co.jp', password: 'admin434', username: '鹿野 宏美', admin: false)
User.create(email: 'dai.omori@persol.co.jp', password: 'admin543', username: '大森 大', admin: false)
User.create(email: 'mio.kakai@persol.co.jp', password: 'admin634', username: '抱井 美緒', admin: false)