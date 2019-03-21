class SetlistMailer < ApplicationMailer
    default from: 'myfavoritesong@gmail.com'

    def add_setlist_email(setlist)
        @setlist = setlist
        @musician = @setlist.musician
        users = @musician.favoriting_users

        mail(
            subject: 'セットリスト追加通知メール',
            to: 'myfavoritesong@gmail.com',
            bcc: users.map{|u| u.email},
            from: 'myfavoritesong@gmail.com'
        )
    end
end
