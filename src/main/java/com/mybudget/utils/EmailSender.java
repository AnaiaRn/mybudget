package com.mybudget.utils;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailSender {
    public static void sendEmail(String to, String subject, String body) throws MessagingException {
        final String username = "anaiarandria62@gmail.com";
        final String password = "asst umiw ijks ohrk "; // À remplacer par un App Password si 2FA activé

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com"); // Ajout important

        // Correction: "getPasswordAuthentication" au lieu de "getPasswordAuthentification"
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setText(body);

            Transport.send(message);
            System.out.println("Email envoyé avec succès à " + to);
        } catch (MessagingException e) {
            System.err.println("Erreur lors de l'envoi d'email: " + e.getMessage());
            throw e; // Propagation de l'exception
        }
    }
}