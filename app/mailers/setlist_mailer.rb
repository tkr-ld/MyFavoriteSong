class SetlistMailer < ApplicationMailer
    default from: ENV['GMAIL_USER_ADDRESS']

    def add_setlist_email(setlist)
        @setlist = setlist
        @musician = @setlist.musician
        users = @musician.favoriting_users

        mail(
            subject: 'セットリスト追加通知メール',
            to: ENV['GMAIL_USER_ADDRESS'],
            bcc: users.map{|u| u.email},
        )
    end
end
