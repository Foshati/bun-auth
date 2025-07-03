# استفاده از Bun
FROM oven/bun:1-alpine

# ایجاد دایرکتوری کار
WORKDIR /app

# کپی package.json و bun.lockb
# فقط فایل‌های مربوط به پکیج‌ها کپی می‌شوند تا از کش لایه‌های داکر بهتر استفاده شود
COPY package.json bun.lockb* ./

# نصب وابستگی‌ها با bun
# --frozen-lockfile برای اطمینان از نصب دقیق پکیج‌ها در محیط CI/CD استفاده می‌شود
RUN bun install --frozen-lockfile

# کپی بقیه فایل‌های پروژه
COPY . .

# Generate Prisma Client
RUN bunx prisma generate

# ساخت پروژه با bun
RUN bun run build

# پورت مورد استفاده
EXPOSE 8000

# دستور اجرای برنامه برای پروداکشن
# از 'start' استفاده می‌کنیم که نسخه بیلد شده را اجرا می‌کند
CMD ["bun", "run", "start"]