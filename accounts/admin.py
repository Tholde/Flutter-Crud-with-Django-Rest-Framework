from django.contrib import admin
from accounts.models import User, OneTimePassword


# Register your models here.
class UserAdmin(admin.ModelAdmin):
    list_display = ("id", "email", "first_name", "last_name", "password",
                    "is_active", "is_staff", "is_superuser", "is_verified", "date_joined", "last_login")


class OneTimePasswordAdmin(admin.ModelAdmin):
    list_display = "id", "user", "code"


admin.site.register(User, UserAdmin)
admin.site.register(OneTimePassword, OneTimePasswordAdmin)
