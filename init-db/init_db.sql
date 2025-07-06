CREATE TABLE subventions (
    id SERIAL PRIMARY KEY,
    organisme VARCHAR(100),
    montant NUMERIC,
    date_versement DATE,
    objet TEXT
);

INSERT INTO subventions (organisme, montant, date_versement, objet) VALUES
('Association Sportive', 2500.00, '2024-01-15', 'Achat de matériel'),
('Maison des Jeunes', 4800.50, '2024-03-20', 'Financement d’activités'),
('École Primaire Jules Ferry', 12000.00, '2024-05-05', 'Travaux de rénovation');
