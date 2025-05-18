<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chatbot BudgetManager</title>
    <style>
        :root {
            --primary-color: #4CAF50;
            --primary-dark: #3e8e41;
            --user-message-bg: #e3f2fd;
            --bot-message-bg: #ffffff;
            --border-color: #e0e0e0;
            --text-color: #333;
            --error-color: #f44336;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', sans-serif;
            line-height: 1.6;
            color: var(--text-color);
            background-color: #f5f5f5;
            padding: 20px;
        }

        .chat-container {
            width: 100%;
            max-width: 600px;
            margin: 0 auto;
            border: 1px solid var(--border-color);
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            height: 80vh;
        }

        .chat-header {
            background: var(--primary-color);
            color: white;
            padding: 15px 20px;
            font-size: 1.2rem;
            font-weight: 600;
            text-align: center;
        }

        .chat-messages {
            flex: 1;
            overflow-y: auto;
            padding: 15px;
            background: #f9f9f9;
            scroll-behavior: smooth;
        }

        .message {
            margin-bottom: 15px;
            max-width: 85%;
            padding: 12px 16px;
            border-radius: 18px;
            line-height: 1.4;
            word-wrap: break-word;
            position: relative;
            animation: fadeIn 0.3s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .user-message {
            background: var(--user-message-bg);
            margin-left: auto;
            border-bottom-right-radius: 5px;
        }

        .bot-message {
            background: var(--bot-message-bg);
            margin-right: auto;
            border: 1px solid var(--border-color);
            border-bottom-left-radius: 5px;
        }

        .error-message {
            background-color: #ffebee;
            border-color: var(--error-color);
            color: var(--error-color);
        }

        .message-time {
            display: block;
            font-size: 0.7rem;
            opacity: 0.7;
            margin-top: 4px;
            text-align: right;
        }

        .typing-indicator {
            color: #666;
            font-style: italic;
            padding: 10px 20px;
            display: none;
            background: white;
            border-top: 1px solid var(--border-color);
        }

        .chat-input-container {
            display: flex;
            padding: 12px;
            background: white;
            border-top: 1px solid var(--border-color);
        }

        #message-input {
            flex: 1;
            padding: 12px 16px;
            border: 1px solid var(--border-color);
            border-radius: 20px;
            outline: none;
            font-size: 1rem;
            transition: border 0.3s;
        }

        #message-input:focus {
            border-color: var(--primary-color);
        }

        #send-button {
            margin-left: 10px;
            padding: 12px 20px;
            background: var(--primary-color);
            color: white;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            font-weight: 600;
            transition: background 0.3s;
        }

        #send-button:hover {
            background: var(--primary-dark);
        }

        #send-button:disabled {
            background: #cccccc;
            cursor: not-allowed;
        }

        /* Style pour mobile */
        @media (max-width: 600px) {
            .chat-container {
                height: 90vh;
                border-radius: 0;
            }

            body {
                padding: 0;
            }
        }
    </style>
</head>
<body>
    <div class="chat-container">
        <div class="chat-header" role="heading" aria-level="1">
            Assistant BudgetManager
        </div>
        <div class="chat-messages" id="chat-messages" role="log" aria-live="polite">
            <div class="bot-message message">
                Bonjour ! Je suis votre assistant intelligent. Posez-moi vos questions sur votre budget ou tout autre sujet.
                <span class="message-time">Aujourd'hui, <%= new java.text.SimpleDateFormat("HH:mm").format(new java.util.Date()) %></span>
            </div>
        </div>
        <div class="typing-indicator" id="typing-indicator">
            L'assistant écrit...
        </div>
        <div class="chat-input-container">
            <input type="text" id="message-input"
                   placeholder="Tapez votre message ici..."
                   aria-label="Votre message"
                   autofocus>
            <button id="send-button" onclick="sendMessage()" aria-label="Envoyer le message">Envoyer</button>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const input = document.getElementById('message-input');
            const sendButton = document.getElementById('send-button');

            // Gestion de l'accessibilité
            input.addEventListener('keypress', function(e) {
                if (e.key === 'Enter' && !e.shiftKey) {
                    e.preventDefault();
                    sendMessage();
                }
            });

            // Désactiver le bouton si le champ est vide
            input.addEventListener('input', function() {
                sendButton.disabled = !this.value.trim();
            });
        });

        function sendMessage() {
            const input = document.getElementById('message-input');
            const message = input.value.trim();
            if (!message) return;

            // Désactiver l'input pendant l'envoi
            input.disabled = true;
            document.getElementById('send-button').disabled = true;

            // Afficher le message de l'utilisateur
            displayMessage('user', message);
            input.value = '';

            // Afficher l'indicateur de typing
            document.getElementById('typing-indicator').style.display = 'block';

            // Envoyer au serveur
            fetch('<%= request.getContextPath() %>/deepseek-chat', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8',
                },
                body: 'message=' + encodeURIComponent(message)
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error(`Erreur HTTP: ${response.status}`);
                }
                return response.json();
            })
            .then(data => {
                if (data.error) {
                    displayMessage('bot', data.error, true);
                } else {
                    displayMessage('bot', data.response);
                }
            })
            .catch(error => {
                console.error('Erreur:', error);
                displayMessage('bot', "Désolé, une erreur est survenue. Veuillez réessayer.", true);
            })
            .finally(() => {
                document.getElementById('typing-indicator').style.display = 'none';
                input.disabled = false;
                input.focus();
            });
        }

        function displayMessage(sender, text, isError = false) {
            const messagesDiv = document.getElementById('chat-messages');
            const messageDiv = document.createElement('div');

            if (isError) {
                messageDiv.className = 'message error-message';
            } else {
                messageDiv.className = `message ${sender}-message`;
            }

            messageDiv.textContent = text;

            // Ajouter l'heure du message
            const timeSpan = document.createElement('span');
            timeSpan.className = 'message-time';
            timeSpan.textContent = new Date().toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});

            messageDiv.appendChild(timeSpan);
            messagesDiv.appendChild(messageDiv);

            // Scroll automatique
            messagesDiv.scrollTop = messagesDiv.scrollHeight;
        }
    </script>
</body>
</html>