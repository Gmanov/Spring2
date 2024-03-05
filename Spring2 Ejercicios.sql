# NIVELL 1

# Exercici 1
# Mostra totes les transaccions realitzades per empreses d'Alemanya.
SELECT *
FROM transaction
JOIN company ON company.id = transaction.company_id
WHERE company.country = "Germany";
#---------------------------------------------------------------------------------------------------------

# Exercici 2
#Màrqueting està preparant alguns informes de tancaments de gestió, 
#et demanen que els passis un llistat de les empreses que han realitzat transaccions 
#per una suma superior a la mitjana de totes les transaccions.

SELECT company.company_name, transaction.amount AS monto_total
FROM company
JOIN transaction ON transaction.company_id = company.id
WHERE transaction.amount > (SELECT AVG(transaction.amount) FROM transaction);
#---------------------------------------------------------------------------------------------------------

#- Exercici 3
#El departament de comptabilitat va perdre la informació de les transaccions 
#realitzades per una empresa, però no recorden el seu nom, només recorden que el 
#seu nom iniciava amb la lletra c. Com els pots ajudar? Comenta-ho acompanyant-ho 
#de la informació de les transaccions. #En este caso les pasaria el listad de transacciones
#para que puedan ver que empresas que empiezan por C han podido ser.

SELECT *
FROM company
JOIN transaction ON transaction.company_id = company.id
WHERE company_name LIKE "c%";
#---------------------------------------------------------------------------------------------------------

#- Exercici 4
#Van eliminar del sistema les empreses que no tenen transaccions registrades,
#lliura el llistat d'aquestes empreses.
SELECT DISTINCT(company.company_name)
FROM company
INNER JOIN transaction ON transaction.company_id = company.id
WHERE transaction.company_id IS NULL;
#---------------------------------------------------------------------------------------------------------
# NIVELL 2

#Exercici 1
#En la teva empresa, es planteja un nou projecte per a llançar algunes campanyes publicitàries
#per a fer competència a la companyia non institute. Per a això, et demanen la llista de totes
#les transaccions realitzades per empreses que estan situades en el mateix país que aquesta companyia.

SELECT *
FROM transaction
JOIN company ON company.id = transaction.company_id
WHERE company.country =
(SELECT company.country
FROM company
WHERE company_name = "non Institute") AND company_name != "non Institute";

#---------------------------------------------------------------------------------------------------------

#Exercici 2
#El departament de comptabilitat necessita que trobis l'empresa que ha realitzat la 
#transacció de major suma en la base de dades.

SELECT company.company_name, transaction.amount
FROM transaction
JOIN company ON company.id = transaction.company_id
ORDER BY amount DESC
LIMIT 1;
#---------------------------------------------------------------------------------------------------------

#NIVELL 3

#Exercici 1
#S'estan establint els objectius de l'empresa per al següent trimestre, 
#per la qual cosa necessiten una base sòlida per a avaluar el rendiment 
#i mesurar l'èxit en els diferents mercats. Per a això, necessiten el llistat
#dels països la mitjana de transaccions dels quals sigui superior a la mitjana general.

SELECT company.country , AVG(transaction.amount)
FROM transaction
JOIN company ON company.id = transaction.company_id
GROUP BY company.country
HAVING AVG(transaction.amount) > (SELECT AVG(transaction.amount)
FROM transaction);
#---------------------------------------------------------------------------------------------------------

#Exercici 2
#Necessitem optimitzar l'assignació dels recursos i dependrà de la capacitat
#operativa que es requereixi, per la qual cosa et demanen la informació sobre 
#la quantitat de transaccions que realitzen les empreses, però el departament de 
#recursos humans és exigent i vol un llistat de les empreses on especifiquis si tenen
#més de 4 transaccions o menys.

SELECT company.company_name,
CASE 
WHEN COUNT(*) >= 4 THEN "4 o més transaccions"
ELSE "menys de 4 transaccions"
END AS num_registros
FROM company
RIGHT JOIN transaction ON transaction.company_id = company.id
GROUP BY company.company_name
#---------------------------------------------------------------------------------------------------------




