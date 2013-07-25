CREATE TABLE "sms"
  (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    "body" varchar(255),
    "from_num" varchar(255),
    "created_at" datetime,
    "updated_at" datetime
  );
