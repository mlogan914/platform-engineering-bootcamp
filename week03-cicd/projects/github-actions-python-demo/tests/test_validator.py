"""Tests for environment validation."""

from app.validator import validate_environment


def test_valid_environments() -> None:
    assert validate_environment("development")
    assert validate_environment("staging")
    assert validate_environment("production")


def test_invalid_environment() -> None:
    assert not validate_environment("test")
    

def test_environment_is_case_insensitive() -> None:
    assert validate_environment("PRODUCTION")