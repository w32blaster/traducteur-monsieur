PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS terms;
DROP TABLE IF EXISTS translations;

-- Project
CREATE TABLE projects (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    default_country_code VARCHAR(2) NOT NULL
);

-- Languages expected for a project. Country code in ISO 3166-1 format
CREATE TABLE project_languages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    country_code VARCHAR(2) NOT NULL,
    project_id INTEGER,
    CONSTRAINT fk_pl_projects
      FOREIGN KEY (project_id) REFERENCES projects(id)
      ON DELETE CASCADE
);

-- Term code (key)
CREATE TABLE terms (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    code TEXT NOT NULL,
    comment TEXT NOT NULL,
    project_id INTEGER,
    CONSTRAINT fk_t_projects
      FOREIGN KEY (project_id) REFERENCES projects(id)
      ON DELETE CASCADE
);

CREATE TABLE translations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    translation TEXT NOT NULL,
    country_code VARCHAR(2) NOT NULL,
    term_id INTEGER,
    CONSTRAINT fk_t_terms
      FOREIGN KEY (term_id) REFERENCES terms(id)
      ON DELETE CASCADE
);
CREATE INDEX language_code_index ON translations(country_code);


-- Insert few Projects
INSERT INTO projects(id, name, default_country_code) values(1, "Project One", "gb");
INSERT INTO projects(id, name, default_country_code) values(2, "Project Two", "ru");


-- Insert some terms
INSERT INTO terms(id, code, comment, project_id) values(1, "main.page.title", "Top title on the main page", 1);
INSERT INTO terms(id, code, comment, project_id) values(2, "main.page.description", "Main page description", 1);
INSERT INTO terms(id, code, comment, project_id) values(3, "main.page.footer", "The header of footer", 1);

INSERT INTO terms(id, code, comment, project_id) values(4, "contact.form.title", "Contact form title", 2);
INSERT INTO terms(id, code, comment, project_id) values(5, "contact.form.submit", "The button on the form submit", 2);
INSERT INTO terms(id, code, comment, project_id) values(6, "contact.us.header", "Contact us page header", 2);

-- insert expected translations for existing projects
INSERT INTO project_languages(country_code, project_id) values("gb", 1);
INSERT INTO project_languages(country_code, project_id) values("ru", 1);
INSERT INTO project_languages(country_code, project_id) values("gr", 1);

INSERT INTO project_languages(country_code, project_id) values("us", 2);
INSERT INTO project_languages(country_code, project_id) values("ru", 2);

-- insert some translations
INSERT INTO translations(translation, country_code, term_id) values("The Title", "gb", 1);
INSERT INTO translations(translation, country_code, term_id) values("Заголовок", "ru", 1);

-- One record partly translated
INSERT INTO translations(translation, country_code, term_id) values("The description", "gb", 2);
INSERT INTO translations(translation, country_code, term_id) values("Подвал", "ru", 3);

INSERT INTO translations(translation, country_code, term_id) values("Fill The form to contact us", "us", 4);
INSERT INTO translations(translation, country_code, term_id) values("Заполните форму, чтобы связаться с нами", "ru", 4);

INSERT INTO translations(translation, country_code, term_id) values("Submit", "us", 5);
INSERT INTO translations(translation, country_code, term_id) values("Отправить", "ru", 5);

-- One record partly translated
INSERT INTO translations(translation, country_code, term_id) values("Contact us", "us", 6);
