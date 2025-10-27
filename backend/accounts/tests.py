"""Integration tests for authentication endpoints."""
from __future__ import annotations

from django.contrib.auth import get_user_model
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APITestCase

User = get_user_model()


class AuthenticationFlowTests(APITestCase):
    def test_register_and_login_flow(self):
        register_url = reverse("accounts:register")
        login_url = reverse("accounts:login")

        response = self.client.post(
            register_url,
            {
                "username": "flutterfan",
                "email": "flutterfan@example.com",
                "password": "SuperSecure123",
                "first_name": "Flutter",
                "last_name": "Fan",
            },
            format="json",
        )
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertIn("token", response.data)
        self.assertEqual(User.objects.count(), 1)

        response = self.client.post(
            login_url,
            {"username": "flutterfan", "password": "SuperSecure123"},
            format="json",
        )
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertIn("token", response.data)
        self.assertEqual(response.data["user"]["email"], "flutterfan@example.com")

    def test_profile_requires_authentication(self):
        profile_url = reverse("accounts:profile")
        response = self.client.get(profile_url)
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)
