# AcademicRubyXLXS
This is a project to practice Ruby and to update Excel files through Ruby and PostgreSQL

## Getting Start!

Make sure you have PostgreSQL Database installed on your machine!

> But, if you haven't installed it yet, I recommend the links below for installation using Ubuntu 22.04:
>
>  * Install PostgreSQL: [Click here!](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-22-04)

#### **Configure the Envs!**
Inside the project directory:

**Copy the `.env-sample` and configure your Postgres database credentials:**
```
cp .env.sample .env
```

**Now, run the command below to build and migrate the database**:
```
make build
```

**Or if you prefer, run it manually**:
```
make db_create
make db_migrate
```

**If necessary, run the command below to drop the database**:
```
make db_drop
```
