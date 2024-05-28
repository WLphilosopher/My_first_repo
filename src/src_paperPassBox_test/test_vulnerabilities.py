import requests
import pytest

# 设置服务器URL
BASE_URL = "http://127.0.0.1:2222"

# 定义ping测试
def test_ping():
    response = None
    try:
        response = requests.get(BASE_URL)
    except requests.exceptions.RequestException as e:
        pytest.fail(f"Ping test failed: {e}")

    assert response is not None, "No response received from the server"
    assert response.status_code == 200, f"Ping test failed with status code {response.status_code}"

# 定义检查服务器是否响应
def test_server_running():
    response = None
    try:
        response = requests.get(BASE_URL)
    except requests.exceptions.RequestException as e:
        pytest.fail(f"Server running test failed: {e}")

    assert response is not None, "No response received from the server"
    assert response.status_code == 200, f"Server running test failed with status code {response.status_code}"

if __name__ == "__main__":
    pytest.main()
