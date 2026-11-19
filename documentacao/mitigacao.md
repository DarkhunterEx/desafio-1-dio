# Medidas de proteção

Os testes do laboratório mostram o risco de manter credenciais previsíveis, como `msfadmin`/`msfadmin`. A partir desses resultados, reuni algumas recomendações para proteger os serviços.

## Senhas e autenticação

Use senhas longas e diferentes para cada serviço. Evite credenciais padrão e combinações comuns, como `123456`, `admin123` e `password`. Um gerenciador de senhas ajuda a criar e guardar essas credenciais.

A troca deve ocorrer quando houver indícios de comprometimento ou quando a senha ainda for a padrão do serviço. Exigir mudanças periódicas sem motivo não é a orientação do [NIST para senhas](https://pages.nist.gov/800-63-4/sp800-63b.html#passwordver).

Quando o serviço oferecer suporte, habilite a autenticação multifator. Assim, conhecer a senha deixa de ser suficiente para concluir o login. Aplicativos autenticadores e chaves de segurança são opções, conforme os recursos disponíveis no sistema.

## Limite de tentativas

Bloqueios temporários e limites de tentativas por conta ou por origem ajudam a reduzir as tentativas automatizadas. Outra opção é aumentar o intervalo de resposta após falhas consecutivas.

Um bloqueio após cinco falhas, por quinze minutos, seria uma configuração de exemplo. Esses valores precisam ser avaliados para cada serviço, considerando também o acesso dos usuários legítimos.

## Serviços e atualizações

Desative serviços que não sejam necessários e restrinja o acesso aos que precisam continuar ativos. FTP e SMB não devem ficar expostos sem necessidade. Para transferência de arquivos, prefira uma alternativa com criptografia, como SFTP.

Mantenha o sistema e os serviços atualizados. Antes de aplicar mudanças em produção, teste as correções e registre o que foi alterado. No laboratório, as versões vulneráveis fazem parte do exercício e devem permanecer isoladas.

## Logs e acompanhamento

Acompanhe os registros de autenticação para identificar sequências de falhas e acessos suspeitos. Dependendo do sistema e do serviço, esses eventos podem aparecer em arquivos como `/var/log/auth.log`, `/var/log/secure` ou nos próprios logs da aplicação. Alertas podem ajudar a perceber situações que merecem análise.

Na documentação dos testes, mantenha também as tentativas que falharam. Registrar o comando, a mensagem de erro e a correção aplicada facilita entender o que aconteceu e repetir o procedimento depois.
